require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @categoryA = Category.new(name: "", description: "Nothing")
    @categoryB = Category.new(name: "Something", description: "Something")
    @categoryC = Category.new(name: "So", description: "Something wrong")
  end

  test "should have a name" do
    assert_not @categoryA.valid?
  end

  test "valid category" do
    assert @categoryB.valid?
  end
  test "Name should be more than 2 characters" do
    assert_not @categoryC.valid?
  end
end
