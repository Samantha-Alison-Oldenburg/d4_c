require 'test_helper'

module D4C
  class PullControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
    end

    test "should get callback" do
      get :callback
      assert_response :success
    end

  end
end
