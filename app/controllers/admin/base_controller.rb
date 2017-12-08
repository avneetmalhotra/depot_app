class Admin::BaseController < ApplicationController
  before_action :ensure_admin

  private 
  
    def ensure_admin
      unless current_user.admin?
        respond_to do |format| 
          format.html { redirect_to store_index_url, notice: "You don't have privilege to access this section" }
        end
      end
    end
end
