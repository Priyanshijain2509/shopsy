# frozen_string_literal: true

# controller for product orders
class OrdersController < ApplicationController
  before_action :authenticate_user!

  # create action when order is placed
  def create
    @product = Product.find(params[:product_id])
    @order = @product.orders.build(order_params)
    if @order.save
      flash[:notice] = 'Order placed successfully'
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
      OrderMailer.order_confirmation(current_user, @product, @order).deliver_now
      flash[:notice] = "You'll recieve a order confirmation mail!"
    else
      flash[:alert] = 'Order could not be placed'
    end
  end

  # update the model when order is cancelled
  def update
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:id])
    if @order.update(status: 'Cancelled')
      flash[:notice] = 'Order cancelled'
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
      OrderMailer.order_cancellation(current_user, @product, @order ).deliver_now
      flash[:notice] = "You'll recieve a order cancellation mail!"
    else
      flash[:alert] = 'Order cancellation failed'
    end
  end

  # to display all my orders
  def show
    @orders = current_user.orders.page params[:page]
  end

  # to display seller dashboard
  def index
    @products = current_user.products.page params[:page]
  end

  private

  def order_params
    params.require(:order).permit(:status, :buyer, :seller, :product_id)
  end
end
