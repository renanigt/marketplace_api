require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    @product_one = products(:one)
    @product_two = products(:two)
  end

  test "list User's products" do
    get api_v1_user_products_url(@user_one)
    assert_response :ok

    assert_equal [@product_one].to_json, response.body
  end

  test "list all Products" do
    get api_v1_products_url
    assert_response :ok

    assert_equal [@product_one, @product_two].to_json, response.body
  end

  test "create Product" do
    assert_difference "Product.count" do
      post api_v1_products_url,
        params: { product: { name: 'Product Test', description: 'Testing creating product', price: BigDecimal("10.23") } },
        headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
        as: :json
    end
    assert_response :created
  end

  test "show Product" do
    get api_v1_product_url(@product_one), as: :json
    assert_response :ok

    assert_equal @product_one.to_json, response.body
  end

  test "update Product" do
    put api_v1_product_url(@product_one),
      params: { product: { name: 'Product Test Updated' } },
      headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
      as: :json
    assert_response :ok

    @product_one.reload

    assert_equal 'Product Test Updated', @product_one.name
  end

  test "delete Product" do
    assert_difference "Product.count", -1 do
      delete api_v1_product_url(@product_one),
        headers: { Authorization: JsonWebToken.encode(user_id: @user_one.id) },
        as: :json
    end
    assert_response :no_content
  end
end
