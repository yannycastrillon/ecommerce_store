class CartsController < ApplicationController
  before_action :ensure_cart_exists, only:[:show, :add_order_item_to_cart]
  before_action :authenticate_user!

  def show
    @order_items = session[:cart].map.with_index do |ele, i|
      # Create new order item and add cart_list_id
      OrderItem.new(ele.reverse_merge!( { cart_list_id:i } ))
    end
  end

  def add_to_cart
    @order_item = OrderItem.new(cart_params)
    @order_item.unit_price = @order_item.product.price
    @order_item.total_price = @order_item.quantity * @order_item.unit_price

    add_order_item_to_cart(@order_item)
    redirect_to cart_path
  end

  def remove_from_cart
    remove_index = params[:cart_list_id].to_i
    session[:cart].delete_at(remove_index)
    redirect_to cart_path, flash: {success:"Element remove from cart, successfully"}
  end

  private
  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end

end
