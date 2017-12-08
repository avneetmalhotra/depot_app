class Admin::ReportsController < Admin::BaseController  
  before_action :set_dates

  def index
    @orders = Order.where(created_at: @from_date..@to_date)
  end

  private

  def get_selected_date(date)
    Date.new(date[:year].to_i, date[:month].to_i, date[:day].to_i)
  end

  def set_dates
    if params[:from_date]
      @from_date = get_selected_date(params[:from_date])
      @to_date = get_selected_date(params[:to_date])
    else
      @from_date = 5.days.ago.beginning_of_day
      @to_date = Time.now
    end
  end
end
