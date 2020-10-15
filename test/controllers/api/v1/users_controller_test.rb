require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
  end

  test "creates user" do
    assert_difference "User.count" do
      post api_v1_users_url, params: { user: { email: 'renanigt@test.com', password: '1234567' } }, as: :json
    end
    assert_response :created
  end

  test "does not create user if email has already been taken" do
    assert_no_difference "User.count" do
      post api_v1_users_url, params: { user: { email: @user.email, password: '1234567' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "update user" do
    put api_v1_user_url(@user),
      params: { user: { email: 'bob2@test.com' } },
      headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
      as: :json
    assert_response :ok

    @user.reload

    assert_equal 'bob2@test.com', @user.email
  end
end
