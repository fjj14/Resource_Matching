require "test_helper"

class RatingTest < ActiveSupport::TestCase
  def setup
    @userA = User.create(first: "Example", last: "User", email: "userrrrr@example.com", username: "userAAAA", password_digest: "somethinghere")
    @userB = User.create(first: "Example", last: "User", email: "user@example.commmm", username: "Asomethingg", password_digest: "somethinghere")
    @ratingA = Rating.new(reviewer_id: @userA.id, rating_number: 444, comment: "Their product was awesome", user_id: @userB.id )
    @ratingB = Rating.new(reviewer_id: @userA.id, rating_number: 4, comment: "", user_id: @userB.id )
    @ratingC = Rating.new(reviewer_id: @userA.id, rating_number: 4, comment: "Their product was awesome", user_id: @userB.id )
  end
  test "Valid rating" do
    assert @ratingC.valid?
  end
   
  test "Number must be between 1 and five" do
    assert_not @ratingA.valid?
  end
  test "Can't have empty comment" do
    assert_not @ratingB.valid?
  end
 
end
