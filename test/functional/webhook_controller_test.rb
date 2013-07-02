require 'test_helper'

class WebhookControllerTest < ActionController::TestCase
  test "should get product_updated" do
    get :product_updated
    assert_response :success
  end

end
