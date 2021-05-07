require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @userA = User.create(first: "Example", last: "User", email: "userrrrr@example.com", username: "userAAAA", password_digest: "somethinghere")
    @productA = Product.create(name: "shoes", description: "a sticker from brandeis that is the perfect size for a phone", price: 50, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
    @productB = Product.create(name: "sticker", description: "a sticker from brandeis that is the perfect size for a phone", price: 50.0, category_id: (Category.all[0]).id, user_id: @userA.id, condition_id: Condition.all.first.id)
    @productC = Product.create(name: "something else", description: "a sticker from brandeis that is the perfect size for a phone", price: 50, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
    @cartC = Cart.create(user_id: @userA.id)
    @line_itemA = LineItem.create(cart_id: @cartC.id, product_id: @productA.id)
    @line_itemA.cart = @cartC
    @line_itemB = LineItem.create(cart_id: @cartC.id, product_id: @productB.id)
    @line_itemB.cart = @cartC
    @line_itemC = LineItem.create(cart_id: @cartC.id, product_id: @productC.id)
    @line_itemC.cart = @cartC
  end
  test "doesn't delete product when line item is deleted" do
    @line_itemC.destroy 
    assert @productC
  end 
end
