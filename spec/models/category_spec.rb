require 'rails_helper'

describe Category, type: :model do
  before do
    @category = FactoryGirl.build(:category)
  end

  describe 'Factory' do
    it 'Has valid default factory ' do
      expect(@category).to be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:products) }
    it { should have_many(:category_products) }
  end

end
