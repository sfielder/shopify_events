require 'test_helper'

class WebhookEventsControllerTest < ActionController::TestCase
  setup do
    @webhook_event = webhook_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:webhook_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create webhook_event" do
    assert_difference('WebhookEvent.count') do
      post :create, webhook_event: { body: @webhook_event.body, class: @webhook_event.class, method: @webhook_event.method }
    end

    assert_redirected_to webhook_event_path(assigns(:webhook_event))
  end

  test "should show webhook_event" do
    get :show, id: @webhook_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @webhook_event
    assert_response :success
  end

  test "should update webhook_event" do
    put :update, id: @webhook_event, webhook_event: { body: @webhook_event.body, class: @webhook_event.class, method: @webhook_event.method }
    assert_redirected_to webhook_event_path(assigns(:webhook_event))
  end

  test "should destroy webhook_event" do
    assert_difference('WebhookEvent.count', -1) do
      delete :destroy, id: @webhook_event
    end

    assert_redirected_to webhook_events_path
  end
end
