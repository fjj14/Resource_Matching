require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @relationship = Relationship.new(follower_id: users(:one).id,
                                     followed_id: users(:two).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
  
end