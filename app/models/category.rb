class Category < ApplicationRecord

  has_many :category_promotions
  has_many :promotions, through: :category_promotions

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
