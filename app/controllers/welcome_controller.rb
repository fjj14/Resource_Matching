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
            @products = Product.where(buyer_id: nil).order('created_at DESC')
        end
       render 'index'
    end

    def index 
        args = {}
        args[:price] = {}
        args[:price][:gte] = params[:price_from] if params[:price_from].present?
        args[:price][:lte] = params[:price_to] if params[:price_to].present?
        args[:category_id] = params[:category_id] if params[:category_id].present?
        args[:condition_id] = params[:condition_id] if params[:condition_id].present?
        args[:date] = params[:date] if params[:date].present?
        price_ranges = [ {to: 10 }, {from: 10.01, to: 20 }, {from: 20.01, to: 30 }, {from: 30.01}]
        @producss = @products.search "*", where: args,  aggs: {price: {ranges: price_ranges }, category_id: {}, condition_id: {}, date: {}}
        @FilterList = []
        @producss.each do |pro|
            @FilterList[@FilterList.length] = Product.find(pro.id)
        end
        if @FilterList != []
            @pros =  Product.where(id: @FilterList.map(&:id)).where(buyer_id: nil).order('created_at DESC')
        end
        @products = @pros
    end
    private
    def like
        @product = Product.find(params[:id])
        if current_user.voted_for? @product 
          @product.unliked_by current_user
        else
          @product.liked_by current_user
        end
        respond_to do |format|
        
          format.js 
        end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        if !@products
            @products = Product.all
        end
      price_ranges = [ {to: 10 }, {from: 10.01, to: 20 }, {from: 20.01, to: 30 }, {from: 30.01}]
      if !@producss
        @producss = Product.search "*",   aggs: {price: {ranges: price_ranges}, category_id: {}, condition_id: {}, date: {}}
      end
      if !@producs
        @producs = Product.search(params.fetch(:name, "*")).to_a
      end
    end
end
