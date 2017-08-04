require 'rails_helper'

describe CategoriesController do
  describe 'GET #index' do
    context 'When current user is Admin list categories' do
      it 'Then populates categories' do
        user = FactoryGirl.create(:user, :admin)
        category = Category.create(name:"New Category 123")
        sign_in user
        get :index
        expect(assigns(:categories)).to include(category)
      end
      it 'Renders :index action' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :index
        expect(response).to render_template :index
      end
    end
    context 'When current_user is Customer' do
      it 'Then Access should be denied' do
        user = FactoryGirl.create(:user, :customer)
        category = FactoryGirl.create(:category)
        sign_in user
        get :index, nil, flash: { warning:"No Authorize" }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #show' do
    context 'When is Admin show category details' do
      it 'Assigns the requested category to @category' do
        category = FactoryGirl.create(:category)
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :show, params: { id: category.id }
        expect(assigns(:category)).to eq category
      end
      it 'Renders the show page' do
        category = FactoryGirl.create(:category)
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :show, params: { id: category.id }
        expect(response).to render_template :show
      end
    end
    context 'When is Customer dont show category details' do
      it "Redirect to the home page" do
        category = FactoryGirl.create(:category)
        user = FactoryGirl.create(:user)
        sign_in user
        get :show, params: { id:category.id }, flash: {warning: "No Authorize"}
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'GET #new' do
    context 'When current user is Admin' do
      it 'Assigns a new category to @category' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
      it 'Renders the :new template' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :new
        expect(response).to render_template :new
      end
    end
    context 'When current user is Customer' do
      it 'Do no assigns a new category to @category' do
        category = FactoryGirl.create(:category)
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :new, params: { id:category.id }, flash: { warning: "No Authorize"}
        expect(response).to redirect_to root_path
      end

      # it 'Redirects to the home page with flash no authorize' do
      #   user = FactoryGirl.create(:user, :customer)
      #   sign_in user
      #   get :index, flash: { warning:"No Authorize" }
      #   expect(response).to render_template :index
      # end
    end
  end

  describe 'GET #edit' do
    context 'When current user is Admin' do
      it 'Assigns an updated category to @category' do
        user = FactoryGirl.create(:user, :admin)
        category = FactoryGirl.create(:category)
        sign_in user
        get :edit, params: { id: category}
        expect(assigns(:category)).to eq category
      end
      it 'Renders the :edit template' do
        user = FactoryGirl.create(:user, :admin)
        category = FactoryGirl.create(:category)
        sign_in user
        get :edit, params: { id:category }
        expect(response).to render_template :edit
      end
    end
    context 'When current user is Customer' do
      it 'Redirects to the home page with flash msg no authorize' do
        user = FactoryGirl.create(:user)
        category = FactoryGirl.create(:category)
        sign_in user
        get :edit, params: { id:category.id }, flash: {warning:"No Authorize"}
        expect(response).to redirect_to root_path
      end
    end
  end

  # describe 'POST #create' do
  #   context 'When current user is Admin and Valid attributes' do
  #     it 'Saves new category in the database' do
  #       user = FactoryGirl.create(:user, :admin)
  #       product = FactoryGirl.create(:product)
  #       category_item = FactoryGirl.new(:category_item)
  #       sign_in user
  #       category_item.product_id = product.id
  #       @request.session[:cart] ||=[]
  #       category_item.attributes.delete("id")
  #       @request.session[:cart] << category_item.attributes
  #       post( :create, params: { product_id:product.id, category: FactoryGirl.attributes_for(:category) })
  #       expect(category).to receive(:save)
  #     end
  #
  #     # it 'receives :save' do
  #     #   post :create, "schools/#{@school.id}/scholarhips", { scholarship: @scholarship.attributes, school_id: @school.id }
  #     #   expect(@scholarship).to receive(:save)
  #     # end
  #
  #     it 'Redirects to categories#show upon save' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       post :create, params: { category: FactoryGirl.attributes_for(:category) }
  #       expect(response).to redirect_to category_path(assigns[:category])
  #     end
  #   end
  #   context 'When current user is Customer or Invalid attributes' do
  #     it "does not save the new category" do
  #       expect{
  #         post :create, params: { category: FactoryGirl.attributes_for(:invalid_category) }
  #       }.to_not change(Category.count)
  #     end
  #     it "Re-renders the :new method" do
  #       post :create, params: { category: FactoryGirl.attributes_for(:invalid_category) }
  #       response.should render_template :new
  #     end
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   before :each do
  #     @category = FactoryGirl.create(:category,
  #       name: "Basket Ball",
  #       price: 0)
  #   end
  #   context 'When current user is Admin and Valid Attributes' do
  #     it 'Locate the requeste category' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @category, category: FactoryGirl.attributes_for(:category) }
  #       expect(assigns(:category)).to eq(@category)
  #     end
  #     it 'Changes @categories attributes' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @category, category: FactoryGirl.attributes_for(:category,
  #         name:'Baseball', price:0) }
  #       @category.reload
  #       expect(@category.name).to eq('Baseball')
  #       expect(@category.price).to eq(0)
  #     end
  #     it 'Redirects to the updated category' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @category, category: FactoryGirl.attributes_for(:category) }
  #       expect(response).to redirect_to @category
  #     end
  #   end
  #   context 'When current user is Customer or Invalid Attributes' do
  #     it 'Does not change @categories attributes' do
  #       patch :update, params: { id: @category, category: FactoryGirl.attributes_for(:category,
  #         name:"Baseball", price:nil) }
  #       @category.reload
  #       expect(@category.name).not_to eq("Baseball")
  #       expect(@category.price).to eq(nil)
  #     end
  #     it "re-renders the :edit template" do
  #       patch :update, params: { id: @category, category: FactoryGirl.attributes_for(:invalid_category) }
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    before :each do
      @category = FactoryGirl.create(:category)
    end
    context 'When user is Admin'  do
      it "Then delete the category" do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        expect{delete :destroy, params: { id:@category.id }}.to change(Category, :count).by(-1)
      end
    end
    it "Redirects to categories#index" do
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, params: { id: @category }
      expect(response).to redirect_to root_path
    end
  end
end
