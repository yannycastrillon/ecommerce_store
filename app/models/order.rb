class Order < ApplicationRecord
  belongs_to :user
  after_initialize :set_default_status, :if => :new_record?
  enum status: [:pending, :cancelled, :complete]

  def set_default_status
    self.status ||= :pending
  end
end
