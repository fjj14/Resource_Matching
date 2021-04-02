class WelcomeController < ApplicationController
    def search
        @category =Category.find_by(id: params[:category][:id])
        if (params[:name].blank? || params[:name] =="") && @category == nil
            @products = Product.all
        else 
            if params[:category].present? && (!params[:name].blank? || params[:name] !="")
                
                @category =Category.find_by(id: params[:category][:id])
                @products = @category.products.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%")    
            elsif params[:category].present? && ( params[:name].blank?|| params[:name] =="")
                @category =Category.find_by(id: params[:category][:id])
                @products = @category.products
            else
              
                @products = Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%")
                #no category
            end
        end
        render 'index'
         
      end
end
