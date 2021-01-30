class Promotion < ApplicationRecord
  validates :name, :discount_rate, :code, :expiration_date, :coupon_quantity, presence: true

  validates :code, uniqueness: true
end
