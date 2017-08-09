class CategoryProduct < ApplicationRecord
  belongs_to :category
  belongs_to :product


  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end

  def self.assign_or_new(attributes)
    obj = CategoryProduct.find_by(product_id:attributes[:product_id],category_id:attributes[:category_id]) || new
    obj.assign_attributes(attributes)
    obj
  end
end
