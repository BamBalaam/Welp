require 'nokogiri'
require 'set'

def init
  File.open('seeds.rb', 'w') do |f|
    f.puts '# ruby encoding: utf-8'
    f.puts 'sql = <<END'
  end
end

def tail
  File.open('seeds.rb', 'a') do |f|
    f.puts 'END'
    f.puts 'conn = ActiveRecord::Base.connection'
    f.puts 'conn.execute(sql)'
  end
end

def fillDB
  cafes = Nokogiri::XML.parse(File.open('datas/Cafes.xml'), nil, 'utf-8').xpath('//Cafe')
  restaurants = Nokogiri::XML.parse(File.open('datas/Restaurants.xml'), nil, 'utf-8').xpath('//Restaurant')
  users(cafes, restaurants)
  places(cafes, restaurants)
  comments(cafes, restaurants)
  tags(cafes, restaurants)
end

def users(cafes, restaurants)
  admins = Set.new
  cafes.each { |cafe| admins.add cafe.attr('nickname') }
  restaurants.each { |restaurant| admins.add restaurant.attr('nickname') }
  users = users_from_comments(cafes, admins)
          .merge(users_from_comments(restaurants, admins))
          .merge(users_from_tags(cafes, admins))
          .merge(users_from_tags(restaurants, admins))
  File.open('seeds.rb', 'a') do |f|
    f.puts "\tINSERT INTO users (username, email, passwd, date_sign_up, is_admin) VALUES"
    f.puts (admins.map { |a| "\t\t('#{a}', '#{a.downcase}@welp.com', crypt('welp', gen_salt('bf',8)), '1/01/1970', TRUE)" }.join(",\n") + ",\n")
    f.puts (users.map { |u| "\t\t('#{u}', '#{u.downcase}@welp.com', crypt('welp', gen_salt('bf',8)), '1/01/1970', FALSE)" }.join(",\n") + ";\n")
  end
end

def places(cafes, restaurants)
  places = []
  cafes.each { |c| places.push places_informations(c) }
  restaurants.each { |r| places.push places_informations(r) }
  cafes_infos = cafes.map { |c| cafes_informations(c) }
  restaurants_infos = restaurants.map { |r| restaurants_informations(r) }
  File.open('seeds.rb', 'a') do |f|
    f.puts "\tINSERT INTO places (creator_id, creation_date, name, street, num, zip, city, longitude, latitude, phone, website) VALUES"
    f.puts (places.join(",\n") + ";\n")
    f.puts "\tINSERT INTO cafes (place_id, smoking, snack) VALUES"
    f.puts (cafes_infos.join(",\n") + ";\n")
    f.puts "\tINSERT INTO restaurants (place_id, price_range, banquet, take_out, delivery, closed) VALUES"
    f.puts (restaurants_infos.join(",\n") + ";\n")
  end
end

def comments(cafes, restaurants)
  comments = []
  cafes.each { |cafe| comments += comments_for_one(cafe) }
  restaurants.each { |restaurants| comments += comments_for_one(restaurants) }
  comments = comments.select { |c| !c.empty? }.map { |c| "\t\t((SELECT place_id FROM places WHERE name = '#{c[:placename]}'), (SELECT user_id FROM users WHERE username = '#{c[:nickname]}'), '#{c[:score]}', '#{c[:text]}', '#{c[:date]}')" }
  File.open('seeds.rb', 'a') do |f|
    f.puts("\tINSERT INTO comments (place_id, user_id, stars, text_comment, creation_date) VALUES")
    f.puts(comments.join(",\n") + ";\n")
  end
end

def comments_for_one(place)
  placename = place.at_xpath('Informations/Name').text.gsub("'", "''")
  begin
    place.at_xpath('Comments').children.each_with_object([]) do |com, comments|
      next if com.nil? || com.attr('nickname').nil?
      h = {}
      h[:placename] = placename
      h[:nickname] = com.attr('nickname')
      h[:date] = com.attr('date')
      h[:score] = com.attr('score')
      h[:text] = com.text.gsub("'", "''")
      comments.push h
    end
  rescue
    []
  end
end

def tags(cafes, restaurants)
  tags = []
  cafes.each { |cafe| tags += tags_for_one(cafe) }
  restaurants.each { |restaurant| tags += tags_for_one(restaurant) }
  tags = tags.select { |t| !t.empty? }.map { |t| "\t\t((SELECT place_id FROM places WHERE name = '#{t[:placename]}'), (SELECT user_id FROM users WHERE username = '#{t[:user]}'), '#{t[:tag]}')" }
  File.open('seeds.rb', 'a') do |f|
    f.puts("\tINSERT INTO tags (place_id, user_id, name) VALUES")
    f.puts(tags.join(",\n") + ";\n")
  end
end

def tags_for_one(place)
  placename = place.at_xpath('Informations/Name').text.gsub("'", "''")
  begin
    place.at_xpath('Tags').children.each_with_object([]) do |t, tags|
      next if t.nil?
      tag = t.attr('name')
      t.children.each do |user|
        user = user.attr('nickname')
        next unless user.is_a? String
        h = {}
        h[:placename] = placename
        h[:tag] = tag
        h[:user] = user
        tags.push(h)
      end
    end
  rescue
    []
  end
end

def users_from_comments(places, admins)
  places.each_with_object(Set.new) do |place, users|
    next if (com = place.at_xpath('Comments')).nil?
    com.children.each do |c|
      next if c.nil?
      name = c.attr('nickname')
      users.add(name) unless name.nil? || admins.include?(name)
    end
  end
end

def users_from_tags(places, admins)
  places.each_with_object(Set.new) do |place, users|
    next if (tag = place.at_xpath('Tags')).nil?
    tag.children.each do |t|
      next if t.nil?
      t.children.each do |u|
        name = u.attr('nickname')
        users.add(name) unless name.nil? || admins.include?(name)
      end
    end
  end
end

def places_informations(place)
  creator = place.attr('nickname')
  creation_date = place.attr('creationDate')
  info = place.at_xpath('Informations')
  name = info.at_xpath('Name').text.gsub("'", "''")
  street = info.at_xpath('Address/Street').text.gsub("'", "''")
  num = info.at_xpath('Address/Num').text
  zipcode = info.at_xpath('Address/Zip').text
  city = info.at_xpath('Address/City').text.gsub("'", "''")
  long = info.at_xpath('Address/Longitude').text
  lat = info.at_xpath('Address/Latitude').text
  phone = (tmp = info.at_xpath('Tel')) ? tmp.text : 'NULL'
  site = (tmp = info.at_xpath('Site')) ? tmp.attr('link') : 'NULL'
  "\t\t((SELECT user_id FROM users WHERE username = '#{creator}'), '#{creation_date}', '#{name}', '#{street}', '#{num}', '#{zipcode}', '#{city}', '#{long}', '#{lat}', '#{phone}', '#{site}')"
end

def cafes_informations(cafe)
  info = cafe.at_xpath('Informations')
  name = info.at_xpath('Name').text.gsub("'", "''")
  smoking = !info.at_xpath('Smoking').nil?
  snack = !info.at_xpath('Snack').nil?
  "\t\t((SELECT place_id FROM places WHERE name = '#{name}'), '#{smoking}', '#{snack}')"
end

def restaurants_informations(restaurant)
  info = restaurant.at_xpath('Informations')
  name = info.at_xpath('Name').text.gsub("'", "''")
  price_range = info.at_xpath('PriceRange').text
  banquet = (tmp = info.at_xpath('Banquet')) ? tmp.attr('capacity') : 'NULL'
  takeaway = !info.at_xpath('TakeAway').nil?
  delivery = !info.at_xpath('Delivery').nil?
  closeInfos = info.at_xpath('Closed')
  close = ['0'] * 14
  unless closeInfos.nil?
    closeInfos.children.each do |cl|
      next if cl.nil?
      day = cl.attr('day').to_i
      case cl.attr('hour')
      when 'am'
        close[day * 2] = '1'
      when 'pm'
        close[day * 2 + 1] = '1'
      else
        close[day * 2] = '1'
        close[day * 2 + 1] = '1'
      end
    end
  end
  "\t\t((SELECT place_id FROM places WHERE name = '#{name}'), '#{price_range}', '#{banquet}', '#{takeaway}', '#{delivery}', B'#{close.join}')"
end

def fuck
  doc = Nokogiri::XML.parse(File.open('datas/places.xml'), nil, 'utf-8')
  places = doc.xpath('//place')
  places.each do |place|
    creator = place.attr('nickname')
    creation_date = place.attr('creationDate')
    place.at_xpath('Informations') do |info|
      name = info.at_xpath('Name').text
      street = info.at_xpath('Address/Street').text
      num = info.at_xpath('Address/Num').text
      zipcode = info.at_xpath('Address/Zip').text
      city = info.at_xpath('Address/City').text
      long = info.at_xpath('Address/Longitude').text
      lat = info.at_xpath('Address/Latitude').text
      smoking = !info.at_xpath('Smoking').nil?
      snack = !info.at_xpath('Snack').nil?
      phone = (tmp = info.at_xpath('Tel')) ? tmp.text : 'NULL'
      site = place.at_xpath('Site')
      site = (tmp = info.at_xpath('Site')) ? tmp.attr('link') : 'NULL'
    end

    comments = []
    place.at_xpath('Comments').children do |com|
      h = {}
      h[:nickname] = com.attr('nickname')
      h[:date] = com.attr('date')
      h[:score] = com.attr('score')
      h[:text] = com.text
      comments.puts h
    end

    tags = []
  end
end

init
fillDB
tail
