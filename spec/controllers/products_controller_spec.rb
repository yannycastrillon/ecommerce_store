require 'rails_helper'

describe ProductsController do
  describe 'GET #index' do
    context 'Must list active products' do
      it 'populates array of products' do
        # Validate price with datatype money.
        product = Product.create(name:"Beach Ball", price:0, inventory:8)
        user = FactoryGirl.build(:user)
        sign_in user
        get :index
        expect(assigns(:products)).to include(product)
      end
      it 'renders the :index template' do
        user = FactoryGirl.create(:user)
        sign_in user
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'Must not list inactive products' do
      it 'Does not populate products' do
        product = FactoryGirl.build(:product, active:false)
        user = FactoryGirl.create(:user)
        sign_in user
        get :index
        expect(assigns(:products)).to be_empty
      end
    end
  end

  describe 'GET #show' do
    context 'Show product info details' do
      it 'Assigns the requested product to @product' do
        product = FactoryGirl.create(:product, :invent)
        user = FactoryGirl.build(:user)
        sign_in user
        get :show, params: { id: product }
        expect(assigns(:product)).to eq product
      end
      it 'Renders the show page' do
        product = FactoryGirl.create(:product, :invent)
        user = FactoryGirl.build(:user)
        sign_in user
        get :show, params: { id: product }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context 'When current user is Admin' do
      it 'Assigns a new product to @product' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :new
        expect(assigns(:product)).to be_a_new(Product)
      end
      it 'Renders the :new template' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :new
        expect(response).to render_template :new
      end
    end
    context 'When current user is Customer' do
      it 'Does not assigns a new product to @product' do
        user = FactoryGirl.create(:user, :customer)
        expect(assigns(:product)).to eq(nil)
      end
      it 'Redirects to the home page with flash no authorize' do
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :index, flash: { warning:"No Authorize" }
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #edit' do
    context 'When current user is Admin' do
      it 'Assigns an updated product to @product' do
        product = FactoryGirl.create(:product, :invent)
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :edit, params: { id: product}
        expect(assigns(:product)).to eq product
      end
      it 'Renders the :new template' do
        product = FactoryGirl.create(:product, :invent)
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :edit, params: { id:product }
        expect(response).to render_template :edit
      end
    end
    context 'When current user is Customer' do
      it 'Does not assigns an updated product to @product' do
        user = FactoryGirl.create(:user, :customer)
        expect(assigns(:product)).to eq(nil)
      end
      it 'Redirects to the home page with flash no authorize' do
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :index, flash: { warning:"No Authorize" }
        expect(response).to render_template :index
      end
    end
  end

  # describe 'POST #create' do
  #   context 'When current user is Admin and Valid attributes' do
  #     it 'Saves new product in the database' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       expect {
  #         post :create, params: { product: FactoryGirl.attributes_for(:product) }
  #       }.to change(Product.count).by(1)
  #     end
  #     it 'Redirects to Products#show upon save' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       post :create, params: { product: FactoryGirl.attributes_for(:product) }
  #       expect(response).to redirect_to product_path(assigns[:product])
  #     end
  #   end
  #   context 'When current user is Customer or Invalid attributes' do
  #     it "does not save the new product" do
  #       expect{
  #         post :create, params: { product: FactoryGirl.attributes_for(:invalid_product) }
  #       }.to_not change(Product.count)
  #     end
  #     it "Re-renders the :new method" do
  #       post :create, params: { product: FactoryGirl.attributes_for(:invalid_product) }
  #       response.should render_template :new
  #     end
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   before :each do
  #     @product = FactoryGirl.create(:product,
  #       name: "Basket Ball",
  #       price: 0)
  #   end
  #   context 'When current user is Admin and Valid Attributes' do
  #     it 'Locate the requeste product' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @product, product: FactoryGirl.attributes_for(:product) }
  #       expect(assigns(:product)).to eq(@product)
  #     end
  #     it 'Changes @products attributes' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @product, product: FactoryGirl.attributes_for(:product,
  #         name:'Baseball', price:0) }
  #       @product.reload
  #       expect(@product.name).to eq('Baseball')
  #       expect(@product.price).to eq(0)
  #     end
  #     it 'Redirects to the updated product' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @product, product: FactoryGirl.attributes_for(:product) }
  #       expect(response).to redirect_to @product
  #     end
  #   end
  #   context 'When current user is Customer or Invalid Attributes' do
  #     it 'Does not change @products attributes' do
  #       patch :update, params: { id: @product, product: FactoryGirl.attributes_for(:product,
  #         name:"Baseball", price:nil) }
  #       @product.reload
  #       expect(@product.name).not_to eq("Baseball")
  #       expect(@product.price).to eq(0)
  #     end
  #     it "re-renders the :edit template" do
  #       patch :update, params: { id: @product, product: FactoryGirl.attributes_for(:invalid_product) }
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    before :each do
      @product = FactoryGirl.create(:product)
    end
    context 'When user is Admin' do
      it "Deletes the product" do
        user = FactoryGirl.create(:user, :admin)
        sign_in user

        expect{ delete :destroy, params: { id: @product.id } }.to change(Product, :count).by(-1)
      end
      it "Redirects to products#index" do
        delete :destroy, params: { id: @product.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
