require 'time'

class SessionsController < ApplicationController
  def new
  end

  def create
    sql = "INSERT INTO users (username, email, passwd, date_sign_up) VALUES ('#{params[:username]}', '#{params[:email]}', crypt('#{params[:password]}', gen_salt('bf',8)), '#{DateTime.now}')"
    ActiveRecord::Base.connection.execute(sql)
  end
end
