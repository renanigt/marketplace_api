class Order < ApplicationRecord
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements
end
