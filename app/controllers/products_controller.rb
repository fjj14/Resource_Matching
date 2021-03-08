class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def create
        @product = Product.new(product_params)
        respond_to do |format|
          if @product.save
            #redirect_to welcome_path, notice: "Succesfully Created Account" 
            format.html { redirect_to welcome_path, notice: "Product was successfully created." }
            #format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end
end
