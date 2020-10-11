require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid" do
    user = User.new(email: 'renanigt@test.com', password: '1234567')
    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(password: '1234567')

    assert_not user.valid?
    assert_not_empty user.errors[:email]
  end

  test "invalid without password" do
    user = User.new(email: 'renanigt')

    assert_not user.valid?
    assert_not_empty user.errors[:password]
  end
end
