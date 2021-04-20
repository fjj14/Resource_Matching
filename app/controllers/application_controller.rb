class ApplicationController < ActionController::Base
    helper_method :current_user, :currently_due 
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.login_path, alert: exception.message
    end
#idea add account transfer here by passing in product param and user id and making the transfer
    include SessionsHelper
    def currently_due
        account = Stripe::Account.retrieve(current_user.stripe_user_id)
        if account.requirements.currently_due.length ==0
          return false
        else
          return true
        end
    end
    def current_user  
        if User.where(id: session[:user_id])  != []
          User.find(session[:user_id])  
        else 
            return nil
        end
      end
 
      
    
end

