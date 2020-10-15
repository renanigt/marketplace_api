require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
    @product = products(:one)
  end

  test "create Product" do
    assert_difference "Product.count" do
      post api_v1_products_url,
        params: { product: { name: 'Product Test', description: 'Testing creating product', price: BigDecimal("10.23") } },
        headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
        as: :json
    end
    assert_response :created
  end

  test "show Product" do
    get api_v1_product_url(@product), as: :json
    assert_response :ok

    assert_equal @product.to_json, response.body
  end

  test "update Product" do
    put api_v1_product_url(@product),
      params: { product: { name: 'Product Test Updated' } },
      headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
      as: :json
    assert_response :success

    @product.reload

    assert_equal 'Product Test Updated', @product.name
  end

  test "delete Product" do
    assert_difference "Product.count", -1 do
      delete api_v1_product_url(@product),
        headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
        as: :json
    end
    assert_response :no_content
  end
end
