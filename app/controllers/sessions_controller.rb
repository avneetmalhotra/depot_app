class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :check_for_inactivity
  skip_before_action :increment_view_counter

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:last_activity_time] = Time.current
      session[:url_view_counter] = Hash.new(0)

      if user.role == 'admin'
        redirect_to admin_reports_url
      else
        redirect_to my_orders_url
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session.clear
    redirect_to store_index_url, notice: "Logged out"
  end
end
