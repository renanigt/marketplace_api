require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid" do
    product = Product.new(
      name: 'Product Name', description: 'Product description', price: BigDecimal("100.0"), user: @user
    )

    assert product.valid?
  end

  test "invalid without name" do
    product = Product.new(
      description: 'Product description', price: BigDecimal("100.0"), user: @user
    )

    assert_not product.valid?
    assert_not_empty product.errors[:name]
  end

  test "invalid without description" do
    product = Product.new(
      name: 'Product Name', price: BigDecimal("100.0"), user: @user
    )

    assert_not product.valid?
    assert_not_empty product.errors[:description]
  end

  test "invalid without price" do
    product = Product.new(
      name: 'Product Name', description: 'Product description', user: @user
    )

    assert_not product.valid?
    assert_not_empty product.errors[:price]
  end

  test "invalid without user" do
    product = Product.new(
      name: 'Product Name', description: 'Product description', price: BigDecimal("100.0")
    )

    assert_not product.valid?
    assert_not_empty product.errors[:user]
  end
end
