require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid" do
    order = Order.new(user: @user, total: 20)

    assert order.valid?
  end

  test "invalid without user" do
    order = Order.new(total: 20)

    assert_not order.valid?
  end

  test "invalid without total" do
    order = Order.new(user: @user)

    assert_not order.valid?
  end

  test "invalid with negative total" do
    order = Order.new(user: @user, total: -1)

    assert_not order.valid?
  end
end
