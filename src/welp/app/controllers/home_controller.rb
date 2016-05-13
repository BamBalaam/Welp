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
  end
end
