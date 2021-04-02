class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
    def index
        @products = Product.all.order('created_at ASC')
    end

    def new 
      @product = Product.new
    end
    def edit 
    
    end
    def create
      @product = Product.new(product_params)
      if !@product[:user_id]
        @product[:user_id] = session[:user_id]
      end
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

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to mypage_path, notice: "Product was successfully updated." }
         # format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @product.destroy
      respond_to do |format|
          format.html { redirect_to mypage_url, notice: "Product was successfully destroyed." }
          format.json { head :no_content }
      end
    end
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end
     
      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit( :name, :price, :image, :description, :category_id)
      end

end

