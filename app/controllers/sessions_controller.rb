class SessionsController < ApplicationController
  def new; end
  
  def create 
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])      
      session[:user_id] = user.id
      if user.cart_id
        session[:cart_id] =Cart.find(user.cart_id).id
      else
        cart = Cart.create
        user.cart = cart
        session[:cart_id] = cart.id
        current_cart.user = current_user
        current_user
      end 
      redirect_to welcome_path
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to root_path
  end
  
end


