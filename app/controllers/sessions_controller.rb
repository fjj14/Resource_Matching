class SessionsController < ApplicationController
  def new
  end

  
  def create 
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])      
      session[:user_id] = user.id
      if user.cart_id
        session[:cart_id] = user.cart
      else
        cart = Cart.create
        user.cart = cart
        session[:cart_id] = cart
      end
      current_cart.user = current_user
      current_cart.save!
      
      redirect_to welcome_path, notice: "Logged in succesfully"
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
   # session[:cart_id]=nil
    redirect_to root_path, notice:"Logged out."
  end
  
end


