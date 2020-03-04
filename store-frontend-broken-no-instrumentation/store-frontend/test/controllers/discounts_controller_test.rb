require 'test_helper'

class DiscountsControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get discounts_get_url
    assert_response :success
  end

  test "should get add" do
    get discounts_add_url
    assert_response :success
  end

end
