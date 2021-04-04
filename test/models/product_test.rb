require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @ProductA = Product.new(name: "shoes", description: "a shoe", price: 50, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
    @ProductB = Product.new(name: "sticker", description: "a sticker from brandeis that is the perfect size for a phone", price: 50.0, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
    @ProductC = Product.new(name: "", description: "a shoe", price: 50, category_id: (Category.all[0]).id, user_id: (User.all[0]).id)
  end 
  test "description is too short" do
     assert_not @ProductA.valid?
  end
  test "name must be present" do
    
    assert_not @ProductC.valid?
  end

  test "Valid product" do
    
    assert @ProductB.valid?
  end
end
