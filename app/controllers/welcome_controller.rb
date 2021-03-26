class WelcomeController < ApplicationController
    def send_message(product)
       
        redirect_to controller: 'conversations', action: 'create_with_param', product: 'product'
    end
end
