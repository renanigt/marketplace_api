require 'test_helper'

class AuthenticableTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @controller = MockController.new
  end

  class MockController
    include Authenticable

    attr_accessor :request

    def initialize
      mock_request = Struct.new(:headers)
      self.request = mock_request.new({})
    end
  end

  test "returns an user for current_user if a valid token" do
    @controller.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
    assert_equal @user, @controller.current_user
  end

  test "returns nil for current_user if there's no token" do
    @controller.request.headers['Authorization'] = nil
    assert_nil @controller.current_user
  end
end
