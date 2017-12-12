class Admin::BaseController < ApplicationController
  before_action :ensure_admin

  private 
  
    def ensure_admin
      unless current_user.admin?
        respond_to do |format| 
          format.html { redirect_to store_index_url, notice: t('admin.base.restricted_access_flash') }
        end
      end
    end
end
