require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @userA = User.new(first: "Example", last: "User", email: "user@example.com", username: "userA", password_digest: "somethinghere")
    @userB = User.new(first: "", last: "User", email: "user@example.com", username: "A", password_digest: "somethinghere")
    @userC = User.new(first: "Example", last: "User", email: "usercom", username: "userA", password_digest: "somethinghere")
  end

  test "should be valid" do
    assert @userA.save
  end

  test "first name should be present and username should be more than 3 characters" do
    assert !@userB.save
  end
  test " invalid email" do
    assert !@userC.save
  end
end
