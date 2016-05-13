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

    sql_fetch_alltags = 'SELECT DISTINCT name FROM tags;'
    @all_tags = ActiveRecord::Base.connection.execute(sql_fetch_alltags)

    sql_fetch_placetags = "SELECT name, count(name) FROM tags WHERE place_id = #{params[:id]} GROUP BY name ORDER BY count DESC;"
    @place_tags = ActiveRecord::Base.connection.execute(sql_fetch_placetags).map { |tag| "#{tag['name']} (#{tag['count']})" }.join(', ')

    sql_fetch_comments = "SELECT c.text_comment, c.stars, c.creation_date, u.username FROM comments c INNER JOIN users u ON c.user_id = u.user_id WHERE place_id = #{params[:id]};"
    @place_comments = ActiveRecord::Base.connection.execute(sql_fetch_comments)

    @mean_note = @place_comments.inject(0) { |acc, comment| acc += comment['stars'].to_f } / @place_comments.count
  end
end
