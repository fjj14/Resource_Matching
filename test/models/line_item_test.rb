require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  def setup 
    @userA = User.create(first: "Example", last: "User", email: "userrrrr@example.com", username: "userAAAA", password_digest: "somethinghere")
    @productC = Product.create(name: "something else", description: "a sticker from brandeis that is the perfect size for a phone", price: 50, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
    @cartC = Cart.create(user_id: @userA.id)
    @line_itemA = LineItem.create(cart_id: nil, product_id: @productC.id)
  end
  test "must belong to a cart " do
    assert_not @line_itemA.valid?
  end
end
