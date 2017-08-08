require 'rails_helper'

describe Product, type: :model do
  before do
    @product = FactoryGirl.build(:product)
  end

  describe 'Factory' do
    it 'has valid default factory' do
      expect(@product).to be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:orders) }
    it { should have_many(:order_items) }
    it { should have_many(:categories) }
    it { should have_many(:category_products) }
  end

  describe '#set_default_values' do
    context 'when inventory not provided' do
      it 'should default inventory to 0' do
        expect(@product.inventory).to eq(0)
      end
      it 'should default active to false' do
        expect(@product.active).to eq(false)
      end
    end

    context 'when inventory provided' do
      it 'should set default active value as true' do
        product = Product.new(name: 'Soccer Ball', price: 15.99, inventory: 12)
        expect(product.active).to eq(true)
      end
    end
  end

end
