class ApplicationController < ActionController::Base
    helper_method :current_user 
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.login_path, alert: exception.message
    end

    include SessionsHelper

    def current_user  
        return unless session[:user_id]  
        @current_user ||= User.find(session[:user_id])  
      end  
end
