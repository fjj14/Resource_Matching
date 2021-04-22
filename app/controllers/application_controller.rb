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
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    
    

     

    def current_cart
      if current_user
        if current_user.cart
          current_user.cart
        else
          cart = Cart.create
          user = User.find(session[:user_id])
          user.cart = cart
          cart.save!
          user.save!
          cart
        end
      else
       cart = Cart.create
       session[:cart_id] = cart.id
       cart
      end  
  end
end

