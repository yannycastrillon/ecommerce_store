class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :is_admin?, :current_order, :ensure_cart_exists, :add_order_item_to_cart,
                :verify_cart_has_items?

  def is_admin?
    unless current_user.admin?
      redirect_to root_path, flash: {error: "Warning! Only Admin privileges"}
    end
  end

  def verify_cart_has_items?
    redirect_to root_path, flash: {error:"Please add item to Cart"} if session[:cart].nil?
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def ensure_cart_exists
    session[:cart] ||= []
  end

  # Add order item to cart
  def add_order_item_to_cart(order_item)
    # validates :cart exists on session.
    session[:cart] << order_item
  end

  def clear_session_cart
    session[:cart] = nil
  end
end
