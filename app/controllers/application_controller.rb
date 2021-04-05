class ApplicationController < ActionController::Base
    
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.login_path, alert: exception.message
    end

    include SessionsHelper
end
