class AdminController < ApplicationController
  
  def index
    redirect_to admin_reports_url if current_user.role == 'admin'
    @total_order = Order.count
  end

end
