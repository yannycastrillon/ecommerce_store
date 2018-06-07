class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :category_products
  has_many :categories, through: :category_products

  after_initialize :set_default_values, :if => :new_record?

  # filters only active products products
  # scope :actives, -> { where(active:true) }
  # scope :inactives, -> { where(active:false) }

  scope :set_active, -> (be_active) { where( active: be_active ) }

  def set_default_values
    self.inventory ||= 0
    self.active = self.inventory > 0 ? true : false
  end

  searchable do
    integer :id
    text :name
    text :description

    text :categories do
      categories.map(&:name)
    end
  end

  def created_month
    created_at.strftime("%B %Y")
  end
  def my_new_user
  end
end
