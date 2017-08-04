class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :category_products
  has_many :categories, through: :category_products

  after_initialize :set_default_values, :if => :new_record?

  # filters only active products products
  scope :actives, -> { where(active:true) }


  def set_default_values
    self.inventory ||= 0
    self.active = self.inventory > 0 ? true : false
  end
end
