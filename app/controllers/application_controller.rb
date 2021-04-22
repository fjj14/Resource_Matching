class ApplicationController < ActionController::Base
    helper_method :current_user, :currently_due, :current_cart
    before_action :current_cart
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
        if User.where(id: session[:user_id])  != nil
          if User.where(id: session[:user_id])  != []
            User.find(session[:user_id])  
          else
            nil
          end
        else 
            return nil
        end
    end
    

     

    def current_cart
      cart= Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
       cart = Cart.create
       session[:cart_id] = cart.id
       #current_user.cart = cart
       cart
    end    
    
end

