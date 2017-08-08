class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  attr_accessor :cart_list_id

  def set_quantity
    self.quantity ||= 1
  end
end
