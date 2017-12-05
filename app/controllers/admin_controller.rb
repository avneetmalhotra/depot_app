class AdminController < ApplicationController
  before_action :ensure_admin

  def index
    redirect_to admin_reports_url if current_user.role == 'admin'
    @total_order = Order.count
  end

  private 
  
    def ensure_admin
      unless current_user.role == 'admin'
        respond_to do |format| 
          format.html { redirect_to store_index_url, notice: "You don't have privilege to access this section" }
        end
      end
    end
end
