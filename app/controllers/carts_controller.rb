class CartsController < ApplicationController
  #before_action :set_cart, only: %i[ show edit update destroy ]
  
 def list_items
  @items = Product.find(@cart)
end
def new 
  @cart = Cart.new
end
def create
  @cart = Cart.new
end
 def remove_item

    @cart.delete_at(params[:index].to_i)

    redirect_to cart_path


 end


end
