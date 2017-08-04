require 'rails_helper'

describe OrdersController do
  describe 'GET #index' do
    context 'When current user is Customer list orders' do
      it 'Then populates cutomer´s orders' do
        # Validate price with datatype money.
        user = FactoryGirl.create(:user, :customer)
        order = Order.create(email:'andres117@gmail.com',user_id:user.id)
        sign_in user
        get :index, params: { user_id: user.id }
        expect(assigns(:orders)).to include(order)
      end
      it 'Renders :index action' do
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :index,  params: { user_id: user.id }
        expect(response).to render_template :index
      end
    end
    context 'When current_user is Admin' do
      it 'Then populates all orders' do
        user = FactoryGirl.create(:user, :admin)
        order = FactoryGirl.create(:order)
        sign_in user
        get :index, params:{ user_id: user.id}
        expect(assigns(:orders)).to include(order)
      end
    end
  end

  describe 'GET #show' do
    context 'Show order details' do
      it 'Assigns the requested order to @order' do
        order = FactoryGirl.create(:order)
        user = FactoryGirl.create(:user)
        sign_in user
        get :show, params: { user_id:user.id, id: order.id }
        expect(assigns(:order)).to eq order
      end
      it 'Renders the show page' do
        order = FactoryGirl.create(:order)
        user = FactoryGirl.create(:user)
        sign_in user
        get :show, params: { user_id:user.id , id: order.id }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context 'When current user is Admin' do
      it 'Assigns a new order to @order' do
        user = FactoryGirl.create(:user, :admin)
        # order = FactoryGirl.build(:order)
        sign_in user
        get :new, params: { user_id:user.id }
        expect(assigns(:order)).to be_a_new(Order)
      end
      it 'Renders the :new template' do
        user = FactoryGirl.create(:user, :admin)
        sign_in user
        get :new, params: { user_id:user.id }
        expect(response).to render_template :new
      end
    end
    context 'When current user is Customer' do
      it 'Assigns a new order to @order' do
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :new, params: { user_id:user.id }
        expect(assigns(:order)).to be_a_new(Order)
      end
      it 'Renders the :new template' do
        user = FactoryGirl.create(:user, :customer)
        sign_in user
        get :new, params: { user_id:user.id }
        expect(response).to render_template :new
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
      it 'Assigns an updated order to @order' do
        user = FactoryGirl.create(:user, :admin)
        order = FactoryGirl.create(:order)
        sign_in user
        get :edit, params: { user_id:user.id, id: order}
        expect(assigns(:order)).to eq order
      end
      it 'Renders the :edit template' do
        user = FactoryGirl.create(:user, :admin)
        order = FactoryGirl.create(:order)
        sign_in user
        get :edit, params: { user_id:user.id, id:order }
        expect(response).to render_template :edit
      end
    end
    context 'When current user is Customer' do
      it 'Redirects to the home page with flash msg no authorize' do
        user = FactoryGirl.create(:user)
        order = FactoryGirl.create(:order)
        sign_in user
        get :edit, params: { user_id:user.id, id:order.id }, flash: {warning:"No Authorize"}
        expect(response).to redirect_to root_path
      end
    end
  end

  # describe 'POST #create' do
  #   context 'When current user is Admin and Valid attributes' do
  #     it 'Saves new order in the database' do
  #       user = FactoryGirl.create(:user, :admin)
  #       product = FactoryGirl.create(:product)
  #       order_item = FactoryGirl.new(:order_item)
  #       sign_in user
  #       order_item.product_id = product.id
  #       @request.session[:cart] ||=[]
  #       order_item.attributes.delete("id")
  #       @request.session[:cart] << order_item.attributes
  #       post( :create, params: { user_id:user.id, order: FactoryGirl.attributes_for(:order) })
  #       expect(order).to receive(:save)
  #     end
  #
  #     # it 'receives :save' do
  #     #   post :create, "schools/#{@school.id}/scholarhips", { scholarship: @scholarship.attributes, school_id: @school.id }
  #     #   expect(@scholarship).to receive(:save)
  #     # end
  #
  #     it 'Redirects to orders#show upon save' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       post :create, params: { order: FactoryGirl.attributes_for(:order) }
  #       expect(response).to redirect_to order_path(assigns[:order])
  #     end
  #   end
  #   context 'When current user is Customer or Invalid attributes' do
  #     it "does not save the new order" do
  #       expect{
  #         post :create, params: { order: FactoryGirl.attributes_for(:invalid_order) }
  #       }.to_not change(Order.count)
  #     end
  #     it "Re-renders the :new method" do
  #       post :create, params: { order: FactoryGirl.attributes_for(:invalid_order) }
  #       response.should render_template :new
  #     end
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   before :each do
  #     @order = FactoryGirl.create(:order,
  #       name: "Basket Ball",
  #       price: 0)
  #   end
  #   context 'When current user is Admin and Valid Attributes' do
  #     it 'Locate the requeste order' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @order, order: FactoryGirl.attributes_for(:order) }
  #       expect(assigns(:order)).to eq(@order)
  #     end
  #     it 'Changes @orders attributes' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @order, order: FactoryGirl.attributes_for(:order,
  #         name:'Baseball', price:0) }
  #       @order.reload
  #       expect(@order.name).to eq('Baseball')
  #       expect(@order.price).to eq(0)
  #     end
  #     it 'Redirects to the updated order' do
  #       user = FactoryGirl.build(:user, :admin)
  #       sign_in user
  #       patch :update, params: { id: @order, order: FactoryGirl.attributes_for(:order) }
  #       expect(response).to redirect_to @order
  #     end
  #   end
  #   context 'When current user is Customer or Invalid Attributes' do
  #     it 'Does not change @orders attributes' do
  #       patch :update, params: { id: @order, order: FactoryGirl.attributes_for(:order,
  #         name:"Baseball", price:nil) }
  #       @order.reload
  #       expect(@order.name).not_to eq("Baseball")
  #       expect(@order.price).to eq(nil)
  #     end
  #     it "re-renders the :edit template" do
  #       patch :update, params: { id: @order, order: FactoryGirl.attributes_for(:invalid_order) }
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    before :each do
      @order = FactoryGirl.create(:order, :cancelled)
    end
    it "Then sets value status as cancelled" do
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, params: { user_id:user.id, id:@order.id }
      expect(@order.status).to eq('cancelled')
    end
    it "Redirects to orders#index" do
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, params: { user_id:user.id, id: @order }
      expect(response).to redirect_to user_orders_path
    end
  end
end
