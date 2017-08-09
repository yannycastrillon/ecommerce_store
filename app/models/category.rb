class Category < ApplicationRecord
  has_many :category_products, dependent: :delete_all
  has_many :products, through: :category_products
  acts_as_tree

  scope :order_by_name, -> { order(:name) }

  # Recursively finds each ancestors name and concatenates with the parent name.
  def ancestors_name
    if parent
      "#{parent.ancestors_name} #{parent.name}:"
    else
      ""
    end
  end

  # Returns a concatenate string with all names of the parents with its own
  def long_name
    "#{ancestors_name} #{name}"
  end

  # searchable do
  #   text :name
  #   integer :id
  # end
end
