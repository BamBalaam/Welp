class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user = nil
    if session[:user_id]
      sql = "SELECT user_id, username, email, date_sign_up, is_admin FROM users WHERE user_id = #{session['user_id']}"
      @current_user ||= begin
                        ActiveRecord::Base.connection.execute(sql).first
                      rescue
                        nil
                      end
    end
  end
end
