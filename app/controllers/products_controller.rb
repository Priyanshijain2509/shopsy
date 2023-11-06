# frozen_string_literal: true

# Product controller for ceating and manipulating products
class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]
  # to display all products
  def index
    @products = current_user.seller? ? current_user.products : Product.all
    @products = @products.page params[:page]
  end

  # create new product
  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:notice] = 'Product successfully created!'
      redirect_to products_url(@product)
    else
      flash[:alert] = 'Error creating the product.'
      render partial: 'products/form'
    end
  end

  # for new product form
  def new
    user_id = params[:user_id]
    @product = User.find(user_id).products.new
  end

  # to edit the product details
  def edit; end

  # to destroy the product
  def destroy
    @product.destroy
    flash[:notice] = 'Product deleted'
    redirect_to request.referrer
  end

  # to update the product details
  def update
    if @product.update(product_params)
      flash[:notice] = 'Product updated'
      redirect_to products_url(@product)
    else
      flash[:alert] = "Product couldn't be updated"
      render 'edit'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :product_name, :product_type, :description, :price, :product_status
    )
  end
end
