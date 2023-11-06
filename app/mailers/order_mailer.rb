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
