class Cart < ApplicationRecord
    has_many :products
    has_many :line_items, dependent: :destroy
    belongs_to :user, optional: true
    def add_item(product_id, cart)

        k = Product.find(product_id)
      
        if !cart.include? (k.id)
         cart.push(k.id)    
        end
    
        redirect_to cart
    
     end
     def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
    
        if current_item
            current_item.quantity += 1 #quantity of line_item, product in cart
        else
            current_item = line_items.build(product_id: product.id)
        end
    current_item
     end
    
end
