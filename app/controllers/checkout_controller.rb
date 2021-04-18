class CheckoutController < ApplicationController
   before_action :set_product, only: %i[ create ]
    def set_product
        @product = Product.new
    end
    def create 
        @product = Product.find(params[:id])
        @product.buyer_id = current_user.id
        if @product.nil?
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
            success_url: checkout_success_url(product: @product.id) ,
            cancel_url: checkout_cancel_url(product: @product.id)
        )

        respond_to do |format|
            format.js 
        end 
    end 
    def success 
       #call account transfer
       # @session = Stripe::Checkout::Session.retrieve(params[:session_id])
       # @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
        @product = Product.where(id: params[:product]).first
       
    end
    def cancel 
        @product = Product.where(id: params[:product]).first
        @product.buyer_id = nil
        redirect_to welcome_path
        
    end 
end
