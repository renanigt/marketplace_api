require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @products = [products(:two), products(:three)]
  end

  test "valid" do
    order = Order.new(user: @user, total: 20, products: @products)

    assert order.valid?
  end

  test "invalid without user" do
    order = Order.new(products: @products)

    assert_not order.valid?
  end

  test "set_total!" do
    order = Order.create!(user: @user, products: @products)

    assert_equal @products.sum(&:price), order.total
  end
end
