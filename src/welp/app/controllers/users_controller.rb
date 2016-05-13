class UsersController < ApplicationController
  def get
    sql_fetch_user = "SELECT username, email, date_sign_up FROM users WHERE user_id = #{params[:id]};"
    @user = ActiveRecord::Base.connection.execute(sql_fetch_user).first
    sql_fetch_comments = "SELECT c.creation_date, c.text_comment, c.stars, p.name FROM comments c INNER JOIN places p ON c.place_id = p.place_id WHERE c.user_id = #{params[:id]};"
    @comments = ActiveRecord::Base.connection.execute(sql_fetch_comments)
    sql_fetch_tags = "SELECT c.name AS tagname, p.name AS placename FROM tags c INNER JOIN places p ON c.place_id = p.place_id WHERE c.user_id = #{params[:id]};"
    @tags = ActiveRecord::Base.connection.execute(sql_fetch_tags)
  end

  def fetcher
    if params[:users_search].nil?
      sql_fetch_allusers = 'SELECT user_id, username, email, date_sign_up FROM users'
    else
      sql_fetch_allusers = "SELECT user_id, username, email, date_sign_up FROM users WHERE lower(username) LIKE '%#{params[:users_search]}%' ORDER BY username = '#{params[:users_search]}' DESC, username ASC"
    end
    @users = ActiveRecord::Base.connection.execute(sql_fetch_allusers)
  end
end
