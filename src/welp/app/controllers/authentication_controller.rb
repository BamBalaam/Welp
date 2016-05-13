class AuthenticationController < ApplicationController
  def sign_in
  end

  def login
    sql = "SELECT * FROM users WHERE username = '#{params[:username]}' AND passwd = crypt('#{params[:password]}', passwd);"
    user = ActiveRecord::Base.connection.execute(sql)

    if user.count == 1
      session[:user_id] = user.first['user_id']
      flash[:notice] = 'Welcome to WELP!'
      redirect_to :root
    else
      flash.now[:error] = 'Unknown user.'
      render action: 'sign_in'
    end
  end

  def signed_out
    session[:user_id] = nil
    flash[:notice] = 'You have been signed out.'
  end

  def new_user
  end

  def register
    sql_select_username = "SELECT * FROM users WHERE username = '#{params[:username]}'"
    valid_username = ActiveRecord::Base.connection.execute(sql_select_username).count == 0
    unless valid_username
      flash.now[:error] = "User #{params[:username]} already exist"
      render action: 'new_user'
      return
    end

    sql_select_email = "SELECT * FROM users WHERE email = '#{params[:email]}'"
    valid_email = ActiveRecord::Base.connection.execute(sql_select_email).count == 0
    unless valid_email
      flash.now[:error] = "Address #{params[:email]} is already registered"
      render action: 'new_user'
      return
    end

    unless params[:password] == params[:password_conf]
      flash.now[:error] = "Passwords doesn't match."
      render action: 'new_user'
      return
    end

    sql_save_user = "INSERT INTO users(username, email, passwd, date_sign_up) VALUES ('#{params[:username]}', '#{params[:email]}', crypt('#{params[:password]}', gen_salt('bf',8)), '#{DateTime.now}') returning user_id"
    saved_id = ActiveRecord::Base.connection.execute(sql_save_user)
    session[:user_id] = saved_id
    flash[:notice] = "Successfully created user #{params[:username]}"
    redirect_to :root
  end

  def account_settings
  end

  def set_account_info
    sql_select_password = "SELECT * FROM users WHERE user_id = '#{current_user['user_id']}' AND passwd = crypt('#{params[:old_password]}', passwd);"
    unless ActiveRecord::Base.connection.execute(sql_select_password).count == 1
      flash.now[:error] = 'Wrong password'
      render action: 'account_settings'
      return
    end

    if params[:username].nil?
      params[:username] = current_user['username']
    else
      sql_select_username = "SELECT * FROM users WHERE username = '#{params[:username]}'"
      valid_username = ActiveRecord::Base.connection.execute(sql_select_username).count == 0
      unless valid_username
        flash.now[:error] = "User #{params[:username]} already exist"
        render action: 'account_settings'
        return
      end
    end

    if params[:email].nil?
      params[:email] = current_user['email']
    else
      sql_select_email = "SELECT * FROM users WHERE email = '#{params[:email]}'"
      valid_email = ActiveRecord::Base.connection.execute(sql_select_email).count == 0
      unless valid_email
        flash.now[:error] = "Address #{params[:email]} is already registered"
        render action: 'account_settings'
        return
      end
    end

    unless params[:new_password] == params[:password_conf]
      flash.now[:error] = "Passwords doesn't match."
      render action: 'account_settings'
      return
    end

    if params[:new_password].nil?
      sql_update_user = "UPDATE users SET username = '#{params[:username]}', email = '#{params[:email]}' WHERE user_id = #{current_user['user_id']};"
    else
      sql_update_user = "UPDATE users SET username = '#{params[:username]}', email = '#{params[:email]}', passwd = crypt('#{params[:new_password]}', gen_salt('bf',8)) WHERE user_id = #{current_user['user_id']};"
    end
    saved_id = ActiveRecord::Base.connection.execute(sql_update_user)
    flash[:notice] = "Successfully updated user #{params[:username]}"
    redirect_to :root
  end
end
