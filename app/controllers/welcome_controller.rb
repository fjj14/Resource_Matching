class WelcomeController < ApplicationController
    before_action :set_product
    def search
        @producs = Product.search(params.fetch(:name, "*")).to_a
        @products =[]
        @productsList =[]
        @producs.each do |prod|
            @productsList[@productsList.length] = Product.find(prod.id)
        end
        if @productsList !=[]
            @products =  Product.where(id: @productsList.map(&:id)).where(buyer_id: nil).order('created_at DESC')
        end
        if @products == []
            @message = "Sorry, we couldn't find the product you were looking for!"
            @products = Product.all.where(buyer_id: nil).order('created_at DESC')
        end
    end

    def index 
        args = []
        args[:price] = params[:price] if params[:price]
        args[:category_id] = params[:category_id] if params[:category_id].present?
        args[:condition] = params[:condition] if params[:condition].present?
        args[:created_at] = params[:created_at] if params[:created_at].present?
        if args !=[]
      #  @producs = Product.search "*",  aggs: {category_id: {}, price: {}, condition: {}, created_at: {}}
            @producs = Product.search "*", where: args,  aggs: {category_id: {}, price: {}, condition: {}, created_at: {}}
        else
            @producs = Product.search "*",  aggs: {category_id: {}, price: {}, condition: {}, created_at: {}}
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.all
    end
end
