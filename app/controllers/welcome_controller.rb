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
        if @products = []
            @message = "Sorry, we couldn't find the product you were looking for!"
            @products = Product.all.where(buyer_id: nil).order('created_at DESC')
        else
            @products = @products.where(buyer_id: nil).order('created_at DESC')
        end
        render 'index'
         
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.all
    end
end
