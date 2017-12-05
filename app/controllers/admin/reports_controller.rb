class Admin::ReportsController < ApplicationController
  before_action :ensure_admin

  def index
    if params[:from_date]
      from_date = get_selected_date(params[:from_date])
      to_date = get_selected_date(params[:to_date])
    else
      from_date = 5.days.ago.beginning_of_day
      to_date = Time.now
    end

    @orders = Order.where(created_at: from_date..to_date)
  end

  private

  def get_selected_date(date)
    Date.new(date[:year].to_i, date[:month].to_i, date[:day].to_i)
  end

  def ensure_admin
    unless current_user.role == 'admin'
      respond_to do |format| 
        format.html { redirect_to store_index_url, notice: "You don't have privilege to access this section" }
      end
    end
  end
end
