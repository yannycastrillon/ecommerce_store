class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:edit,:update]
  before_action :authenticate_user!

  # GET /orders
  def index
     @orders = current_user.admin? ? Order.all : Order.where(user_id:current_user.id)
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    session[:cart].each { |cart_oi| @order.total += cart_oi["total_price"].to_d }
    if @order.save
      if session[:cart].size != 0
        session[:cart].map do |cart_oi|
          oi = OrderItem.new(cart_oi)
          oi.order = @order
          oi.save!
        end
      end
      # clear out the order items from the shopping cart
      clear_session_cart
      redirect_to user_order_path(current_user,@order), notice: "Order was successfully created with id: #{@order.id}"
    else
      render :new
    end

  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to user_order_path(current_user,@order), notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.update(status: :cancelled)
    redirect_to user_orders_path(current_user), notice: 'Order was successfully Cancelled.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:email, :bill_firstname, :bill_lastname, :bill_address1, :bill_address2, :bill_city, :bill_state, :bill_zipcode, :phone, :status,:user_id)
    end
end
