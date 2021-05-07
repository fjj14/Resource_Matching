require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @userA = User.create(first: "Example", last: "User", email: "user@example.com", username: "userA", password_digest: "somethinghere")
    @userB = User.new(first: "", last: "User", email: "user@example.com", username: "A", password_digest: "somethinghere")
    @userC = User.new(first: "Example", last: "User", email: "usercom", username: "userA", password_digest: "somethinghere")
  end

  test "should be valid" do
    assert @userA.save
  end

  test "first name should be present and username should be more than 3 characters" do
    assert !@userB.save
  end
  test "invalid email" do
    assert !@userC.save
  end
  test "cannot create product without stripe id" do
    @ProductA = Product.new(name: "shoes", description: "first name should be present and username should be more than 3 characters", price: 50, category_id: (Category.all[0]).id, condition_id: Condition.all.first.id, user_id: @userA.id)
    assert_not @ProductA.valid?
  end
 
end
