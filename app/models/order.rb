class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user

  after_initialize :set_default_status, :if => :new_record?
  enum status: [:pending, :cancelled, :complete]

  def set_default_status
    self.status ||= :pending
  end
end
