class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  # ...
  before_action :authorize
  protect_from_forgery with: :exception
  helper_method :current_user
    # ...

  around_action :add_responded_in_header_to_response_headers

  protected

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorize
      if request.format == Mime[:html]
        unless User.find_by(id: session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      else
        authenticate_or_request_with_http_basic do |username, password|
          user = User.find_by(name: username)
          user && user.authenticate(password)
        end
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = 
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

  private

    def add_responded_in_header_to_response_headers
      start = Time.now
      yield
      duration = start - Time.now
      response.headers['x-responded-in'] = duration
    end
end