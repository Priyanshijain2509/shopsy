# frozen_string_literal: true

# to send the mail when a buyer order or cancel a product
class OrderMailer < ApplicationMailer
  def order_confirmation(user, product, order)
    @user = user
    @order = order
    product = product
    mail(to: user.email, subject: 'Order Confirmation')
  end

  def order_cancellation(user, product, order)
    @user = user
    @order = order
    product = product
    mail(to: user.email, subject: 'Order Cancellation')
  end
end
