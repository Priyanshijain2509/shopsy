# frozen_string_literal: true

class ProductsController < ApplicationController

  def index
    if current_user.role == 'seller'
      @products = current_user.products.page params[:page]
    else
      @products = Product.page params[:page]
    end
  end
  
  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:success] = 'Product Listed'
      redirect_to products_url(@product)
    else
      flash[:error] = "Product can't be created"
      render partial: 'products/form'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    user_id = params[:user_id]
    @product = User.find(user_id).products.new
  end
  
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = 'Product deleted'
    redirect_to request.referrer
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = 'Product updated'
      redirect_to products_url(@product)
    else
      flash[:error] = "Product couldn't be updated"
      render 'edit'
    end
  end
  
  def seller_dashboard
    @products = current_user.products.page params[:page]
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, 
      :product_type, :description, :price)
  end

end
