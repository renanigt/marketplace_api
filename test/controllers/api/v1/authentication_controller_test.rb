require 'test_helper'

class Api::V1::AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
  end

  test 'should get JWT token' do
    post api_v1_auth_url, params: { user: { email: @user_one.email, password: '123abcd#' } }, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test 'should not get JWT token' do
    post api_v1_auth_url, params: { user: { email: @user_one.email, password: 'wrongpassword' } }, as: :json
    assert_response :unauthorized
  end
end
