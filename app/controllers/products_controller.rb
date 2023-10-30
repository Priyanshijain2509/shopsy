# frozen_string_literal: true

# Product controller for ceating and manipulating products
class ProductsController < ApplicationController
  # to display all products
  def index
    if current_user.role == 'seller'
      @products = current_user.products.page params[:page]
    else
      @products = Product.page params[:page]
    end
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

  # for displaying all products to admin
  def show
    @users = User.where(role: 'seller').page params[:page]
  end

  # for new product form
  def new
    user_id = params[:user_id]
    @product = User.find(user_id).products.new
  end

  # to edit the product details
  def edit
    @product = Product.find(params[:id])
  end

  # to destroy the product
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = 'Product deleted'
    redirect_to request.referrer
  end

  # to update the product details
  def update
    @product = Product.find(params[:id])
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
