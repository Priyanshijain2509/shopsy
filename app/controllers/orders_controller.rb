# frozen_string_literal: true

# controller for product orders
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create update]

  # create action when order is placed
  def create
    @order = @product.orders.build(order_params)
    if @order.save
      send_order_confirmation_email
    else
      flash[:alert] = 'Order could not be placed'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  # update the model when order is cancelled
  def update
    @order = Order.find(params[:id])
    if @order.update(status: 'Cancelled')
      send_order_cancellation_email
    else
      flash[:alert] = 'Order cancellation failed'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  # to display seller dashboard and buyer's order
  def index
    if current_user.role == 'seller'
      @products = current_user.products.page(params[:page])
    elsif current_user.role == 'buyer'
      @orders = current_user.orders.page(params[:page])
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :buyer, :seller, :product_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def send_order_confirmation_email
    OrderMailer.order_confirmation(current_user, @order).deliver_now
    flash[:notice] = "You'll receive an order confirmation email!"
  end

  def send_order_cancellation_email
    OrderMailer.order_cancellation(current_user, @order).deliver_now
    flash[:notice] = "You'll receive an order cancellation email!"
  end
end
