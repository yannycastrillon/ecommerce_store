class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  after_initialize :set_default_active, :if => :new_record?

  # filters only active products products
  scope :actives, -> { where(active:true)}

  def set_default_active
    self.active ||= true
  end
end
