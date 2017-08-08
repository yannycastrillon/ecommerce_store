require 'rails_helper'

describe User, type: :model do
  #let(:user) { FactoryGirl.build(:user) }
  #let!(:user) { FactoryGirl.build(:user) }

  before do
    @user = FactoryGirl.build(:user)
  end

  describe 'Factory' do
   it 'has valid default factory' do
     expect(@user).to be_valid
   end
  end

  describe 'Validations' do

  end

  describe 'Associations' do
    it { should have_many(:orders) }
  end

  describe 'Enums' do
    it { should define_enum_for(:role) }

    context 'role enum' do
      [:admin, :customer].each do |value|
        it { should allow_value(value).for(:role) }
      end

      it 'does not allow invalid value' do
        expect { should allow_value(:invalid).for(:role) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#set_default_role' do
    context 'when role is not provided' do
      it 'should set default role as customer' do
        expect(@user.role).to eq('customer')
      end
    end

    context 'when role is provided' do
      it 'should set expected role' do
        user = FactoryGirl.build(:user, :admin)
        expect(user.role).to eq('admin')
      end
    end
  end
end
