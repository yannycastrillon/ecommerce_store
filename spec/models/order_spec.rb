require 'rails_helper'

describe Order, type: :model do
  before do
    # product = FactoryGirl.build(:product)
    @order = FactoryGirl.build(:order)
  end


  describe 'Factory' do
    it 'Has valid default factory ' do
      expect(@order).to be_valid
    end
  end

  describe 'Enum' do
    it { should define_enum_for(:status) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:products) }
    it { should have_many(:order_items) }
  end

  describe 'Given default values' do
    context 'When create order' do
      it 'Should default status as pending' do
        expect(@order.status).to eq('pending')
      end
      it 'Should default total as 0' do
        expect(@order.total).to eq(0)
      end
    end
  end

end
