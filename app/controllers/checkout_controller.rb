class CheckoutController < ApplicationController
   before_action :set_product, only: %i[ create ]
    def set_product
        @product = Product.new
    end

    def create  
        if Product.where(id: params[:id]) == []
            self.create_from_cart
            return
        end 
        if !current_user
            redirect_to Product.find( params[:id])
            return
        end
        @product = Product.find( params[:id])
        #@product.update!(buyer_id: current_user.id)
        
        if @product.nil?
            self.create_from_cart
            redirect_to welcome_path
            return
        end
        #setting up a stripe session for payment
        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: [{
                name: @product.name,
                description: @product.description,
                amount: ((@product.price) *100).to_i,
                currency: 'usd',
                quantity: 1
            }],
           
            success_url: checkout_success_url+"?session_id={CHECKOUT_SESSION_ID}&product=#{@product.id}",
            cancel_url: checkout_cancel_url(product: @product.id)
        )
        respond_to do |format|
            format.js 
        end 
    end 

    def create_from_cart
        @cart = current_cart
        @allProducts = current_cart.getProducts
        @totalPrice = ((current_cart.totalPrice * 100)* 1.08)
        @name = ""
        current_cart.line_items.each do |item|
            @name = @name + "#{item.product.name}" + "\tquantity: #{item.quantity}\n"
            @product = item.product
            
        end
        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: [{
                name: @name,
                description: "These are all the products in your cart. Thank you for shopping with us!",
                amount: (@totalPrice).to_i,
                currency: 'usd',
                quantity: 1
            }],
           
            success_url: checkout_success_url+"?session_id={CHECKOUT_SESSION_ID}&products=#{@allProducts}",
            cancel_url: checkout_cancel_url(product: nil, products: @allProducts)
        )
    end

    def success 
       #call account transfer
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent).application_fee_amount.to_f
       #buying a list of products from checkout
        if Product.where(id: params[:product]) == []
            @products = params[:products]
            @all = []
            if @products.index(',') == nil
                product= (@products.from(1).to(-2)).to_i
                @product = Product.find(product)
                @product.update!(buyer_id: current_user.id)
                @all[@all.length]= @product
                seller = User.find(@product.user_id)
               
                    transfer = Stripe::Transfer.create({
                    amount: (((@product.price) *100).to_i),
                    currency: 'usd',
                    destination: seller.stripe_user_id,
                    })
               
            else
                @all =[]
                @products.tr('[]', '').split(',').map(&:to_i).each do |i|
                    @product = Product.find(i)
                    @product.update!(buyer_id: current_user.id)
                    @all[@all.length] = @product
                    seller = User.find(@product.user_id)
                   
                        transfer = Stripe::Transfer.create({
                        amount: (((@product.price) *100).to_i),
                        currency: 'usd',
                        destination: seller.stripe_user_id,
                        })
                    
                end
            end
        else
            @product = Product.find(params[:product])
            @product.update!(buyer_id: current_user.id)
            seller = User.find(@product.user_id)
            
                transfer = Stripe::Transfer.create({
                amount: (((@product.price) *100).to_i),
                currency: 'usd',
                destination: seller.stripe_user_id,
                })
            
        end
    end

    def cancel  
        #buying from checkout
        if Product.where(id: params[:product]) == []
            @products = params[:products]
            @products.each do |i|
                @product = Product.find(i)
                
            end    
        else
            #buying from buy now
            @product = Product.find(params[:product])
            
        end
        redirect_to welcome_path  
    end 
end
