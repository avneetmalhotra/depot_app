class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :check_for_inactivity

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:last_activity_time] = Time.now
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:last_activity_time] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
