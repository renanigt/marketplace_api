require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    @order = orders(:one)
    @products = [products(:two), products(:three)]
  end

  test 'list orders' do
    get api_v1_orders_url, headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) }, as: :json
    assert_response :ok

    assert_equal [@order].to_json, response.body
  end

  test 'show order' do
    get api_v1_order_url(@order), headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) }, as: :json
    assert_response :ok

    assert_equal @order.to_json, response.body
  end

  test 'create order' do
    assert_difference 'Order.count' do
      post api_v1_orders_url,
          params: { order: { product_ids: @products.pluck(:id) } },
          headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
          as: :json
    end

    assert_response :created
  end
end
