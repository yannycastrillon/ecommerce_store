require 'rails_helper'

describe UsersController do
  describe '#index' do
    context 'When admin' do
      it 'populates array of users' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :index
        expect(assigns(:users)).to include(user)
      end

      it 'renders the :index template' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'When customer' do
      it 'redirects to root path' do
        user = FactoryGirl.create(:user)
        sign_in user
        get :index
        expect(response).to redirect_to root_url
      end
    end
  end
end
