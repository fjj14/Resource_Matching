class WelcomeController < ApplicationController
    before_action :set_product
    def search
        @category =Category.find_by(id: params[:category][:id])
        if (params[:name].blank? || params[:name] =="") && @category == nil
            @products = Product.all
        else 
            if @category!=nil && (!params[:name].blank? || params[:name] !="")
                
                @category =Category.find_by(id: params[:category][:id])
                @products = @category.products.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%")    
            elsif @category!=nil && ( params[:name].blank?|| params[:name] =="")
                @category =Category.find_by(id: params[:category][:id])
                @products = @category.products
            else
              
                @products = Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%")
                #no category
            end
        end
        render 'index'
         
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.all
    end
end
