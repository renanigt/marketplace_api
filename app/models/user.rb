class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, format: { with: /@/ }

  has_secure_password
end
