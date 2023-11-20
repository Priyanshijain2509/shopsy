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
      render json: { success: true, order: @order,
                     message: 'Order successfully placed!' }, status: :created
    else
      flash[:alert] = 'Order could not be placed'
      render json: { success: false, errors: @order.errors.full_messages },
                      status: :unprocessable_entity
    end
  end

  # update the model when order is cancelled
  def update
    @order = Order.find(params[:id])
    if @order.update(status: 'Cancelled')
      send_order_cancellation_email
      render json: { success: true, order: @order,
                     message: 'Order Cancelled!' }, status: :ok
    else
      flash[:alert] = 'Order cancellation failed'
      render json: { success: false, errors: @order.errors.full_messages },
                      status: :unprocessable_entity
    end
  end

  # to display seller dashboard and buyer's order
  def index
    if current_user.role == 'seller'
      products = current_user.products.includes(orders: :org_buyer)
      render json: products, include: { orders: { include: :org_buyer } }
    elsif current_user.role == 'buyer'
      orders = current_user.orders.includes(:product)
      render json: orders, include: :product
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
