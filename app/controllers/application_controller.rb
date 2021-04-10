class ApplicationController < ActionController::Base
    helper_method :current_user 
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.login_path, alert: exception.message
    end

    include SessionsHelper

    def current_user  
        if User.where(id: session[:user_id])  != []
          User.find(session[:user_id])  
        else 
            return nil
        end
      end
      
      
    
end

