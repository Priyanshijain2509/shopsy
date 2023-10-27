# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @order = @product.orders.build(order_params)
    if @order.save
      flash[:success] = 'Order placed successfully'
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js 
      end
      OrderMailer.order_confirmation(current_user, @product, @order ).deliver_now
      flash[:info] = "You'll recieve a order confirmation mail!"
    else
      flash[:error]= 'Order could not be placed'
    end
  end

  def update
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:id])
    if @order.update(status: 'Cancelled')
      flash[:success] = 'Order cancelled'
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js 
      end
      OrderMailer.order_cancellation(current_user, @product, @order ).deliver_now
      flash[:info] = "You'll recieve a order cancellation mail!"
    else
      flash[:error]= 'Order cancellation failed'
    end
  end

  private
  def order_params
    params.permit(:status, :buyer, :seller, :product_id)
  end
  
end
