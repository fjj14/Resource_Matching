class WelcomeController < ApplicationController
    before_action :set_product
    def search
        @producs = Product.search(params.fetch(:name, "*")).to_a
        @products = []
        @productsList = []
        @producs.each do |prod|
            @productsList[@productsList.length] = Product.find(prod.id)
        end
        if @productsList != []
            @products =  Product.where(id: @productsList.map(&:id)).where(buyer_id: nil).order('created_at DESC')
        end
        if @products.empty?
            @message = "Sorry, we couldn't find the product you were looking for!"
            @products = Product.all.where(buyer_id: nil).order('created_at DESC')
        end
       # render 'index'
    end

    def index 
        args = {}
        args[:price] = {}
        args[:price][:gte] = params[:price_from] if params[:price_from].present?
        args[:price][:lte] = params[:price_to] if params[:price_to].present?
        args[:category_id] = params[:category_id] if params[:category_id].present?
        args[:condition] = params[:condition] if params[:condition].present?
        args[:created_at] = params[:created_at] if params[:created_at].present?
        price_ranges = [ {to: 10 }, {from: 10.01, to: 20 }, {from: 20.01, to: 30 }, {from: 30.01}]
        #  @producs = Product.search "*",  aggs: {category_id: {}, price: {}, condition: {}, created_at: {}}
        @producss = Product.search "*", where: args,  aggs: {price: {ranges: price_ranges }, category_id: {}, condition: {}, created_at: {}}
        @FilterList = []
        @producss.each do |pro|
            @FilterList[@FilterList.length] = Product.find(pro.id)
        end
        if @FilterList != []
            @pros =  Product.where(id: @FilterList.map(&:id)).where(buyer_id: nil).order('created_at DESC')
        end
        @products = @pros & @products
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.all
    end
end
