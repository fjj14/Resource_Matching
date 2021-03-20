class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new 
      @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        @product[:user_id] = session[:user_id]
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

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit( :name, :price, :image, :description)
      end

end

