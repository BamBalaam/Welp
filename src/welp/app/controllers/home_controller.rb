class HomeController < ApplicationController
  def index
    sql_select_places = 'SELECT place_id, name, street, num, zip, city, phone, website FROM places;'
    @places = ActiveRecord::Base.connection.execute(sql_select_places)
  end

  def show_place
    sql_fetch_place = "SELECT * FROM places WHERE place_id = #{params[:id]};"
    @place_info = ActiveRecord::Base.connection.execute(sql_fetch_place).first
    sql_fetch_type = "SELECT * FROM #{@place_info['kind']}s WHERE place_id = #{params[:id]}"
    @type_info = ActiveRecord::Base.connection.execute(sql_fetch_type).first

    sql_fetch_alltags = 'SELECT DISTINCT name FROM tags ORDER BY name ASC;'
    @all_tags = ActiveRecord::Base.connection.execute(sql_fetch_alltags).sort_by { |t| t['name'] }.map(&:to_a).map(&:last)

    sql_fetch_placetags = "SELECT name, count(name) FROM tags WHERE place_id = #{params[:id]} GROUP BY name ORDER BY count DESC;"
    @place_tags = ActiveRecord::Base.connection.execute(sql_fetch_placetags).map { |tag| "#{tag['name']} (#{tag['count']})" }.join(', ')

    sql_fetch_comments = "SELECT c.text_comment, c.stars, c.creation_date, u.username FROM comments c INNER JOIN users u ON c.user_id = u.user_id WHERE place_id = #{params[:id]} ORDER BY c.creation_date DESC;"
    @place_comments = ActiveRecord::Base.connection.execute(sql_fetch_comments)

    @mean_note = @place_comments.inject(0) { |acc, comment| acc += comment['stars'].to_f } / @place_comments.count
  end

  def add_tag
    newtag = params[:addtagmanual].nil? ? params[:addtag] : params[:addtagmanual]
    sql_fetch_tag = "SELECT * FROM tags WHERE place_id = #{params[:id]} AND user_id = #{current_user['user_id']} AND name = '#{newtag}'"
    if ActiveRecord::Base.connection.execute(sql_fetch_tag).count != 0
      flash.now[:error] = 'You have already flagged this tag'
    else
      sql_add_tag = "INSERT INTO tags(place_id, user_id, name) VALUES (#{params[:id]}, #{current_user['user_id']}, '#{newtag}');"
      ActiveRecord::Base.connection.execute(sql_add_tag)
    end
    redirect_to action: 'show_place'
  end

  def new_comment
  end

  def add_comment
    sql_fetch_comment_date = "SELECT creation_date FROM comments WHERE place_id = #{params[:id]} AND user_id = #{current_user['user_id']};"
    last_comment = ActiveRecord::Base.connection.execute(sql_fetch_comment_date)
    if last_comment.max { |c| c['creation_date'] } == DateTime.now.to_date.to_s
      flash.now[:error] = 'You have already commented this place today'
    else
      sql_add_comment = "INSERT INTO comments(place_id, user_id, stars, text_comment, creation_date) VALUES (#{params[:id]}, #{current_user['user_id']}, #{params[:stars]}, '#{params[:comment].gsub("'", "''")}', '#{DateTime.now.to_date}')"
      ActiveRecord::Base.connection.execute(sql_add_comment)
    end
    redirect_to action: 'show_place'
  end

  def edit_place
    sql_fetch_place = "SELECT * FROM places WHERE place_id = #{params[:id]};"
    @place_info = ActiveRecord::Base.connection.execute(sql_fetch_place).first
    sql_fetch_type = "SELECT * FROM #{@place_info['kind']}s WHERE place_id = #{params[:id]}"
    @type_info = ActiveRecord::Base.connection.execute(sql_fetch_type).first
    @days = ['Monday AM', 'Monday PM', 'Tuesday AM', 'Tuesday PM', 'Wednesday AM', 'Wednesday PM', 'Thursday AM', 'Thursday PM', 'Friday AM', 'Friday PM', 'Saturday AM', 'Saturday PM', 'Sunday AM', 'Sunday PM']
  end

  def change_place
    sql_update_place = "UPDATE places SET name = '#{params[:name]}', street = '#{params[:street]}', num = #{params[:num]}, zip = '#{params[:zip]}', city = '#{params[:city]}', phone = '#{params[:phone]}', website = '#{params[:website]}' WHERE place_id = #{params[:id]} returning kind"
    kind = ActiveRecord::Base.connection.execute(sql_update_place).first['kind']
    case kind
    when 'restaurant'
      sql_update_restaurant = "UPDATE restaurants SET price_range = #{params[:price_range]}, banquet = #{params[:banquet]}, take_out = '#{params[:take_out] == 't'}', delivery = '#{params[:delivery] == 't'}' WHERE place_id = #{params[:id]};"
      ActiveRecord::Base.connection.execute(sql_update_restaurant)
    when 'cafe'
      sql_update_cafe = "UPDATE cafes SET smoking = '#{params[:smoking] == 't'}', snack = '#{params[:snack] == 't'}' WHERE place_id = #{params[:id]};"
      ActiveRecord::Base.connection.execute(sql_update_cafe)
    else
      sql_update_hotel = "UPDATE hotels SET num_stars = #{params[:num_stars]}, num_rooms = #{params[:num_rooms]}, price_range_double_room = #{params[:price_range_double_room]} WHERE place_id = #{params[:place_id]};"
      ActiveRecord::Base.connection.execute(sql_update_hotel)
    end
    redirect_to action: 'show_place'
  end
end
