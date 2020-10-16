require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
  end

  test "creates user" do
    assert_difference "User.count" do
      post api_v1_users_url, params: { user: { email: 'renanigt@test.com', password: '1234567' } }, as: :json
    end
    assert_response :created
  end

  test "does not create user if email has already been taken" do
    assert_no_difference "User.count" do
      post api_v1_users_url, params: { user: { email: @user_one.email, password: '1234567' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "update user" do
    put api_v1_user_url(@user_one),
      params: { user: { email: 'one2@test.com' } },
      headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
      as: :json
    assert_response :ok

    @user_one.reload

    assert_equal 'one2@test.com', @user_one.email
  end

  test "destroy user" do
    assert_difference "User.count", -1 do
      assert_difference "Product.count", -1 do
        delete api_v1_user_url(@user_one),
          headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
          as: :json
      end
    end
    assert_response :no_content
  end
end
