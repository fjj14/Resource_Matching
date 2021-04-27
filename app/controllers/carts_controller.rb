class CartsController < ApplicationController
  #before_action :set_cart, only: %i[ show edit update destroy ]
  def create
    @cart = Cart.new
  end
end
