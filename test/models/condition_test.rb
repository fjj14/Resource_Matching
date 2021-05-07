require "test_helper"

class ConditionTest < ActiveSupport::TestCase
  def setup 
    @ConditionL = Condition.new(name: "")
  end
  test "name must be present" do
    
    assert_not @ConditionL.valid?
  end
end
