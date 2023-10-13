# frozen_string_literal: true

class ProductsController < ApplicationController

  # before_action :set_product, only [:show]

  def index
    @products = Product.all
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:success] = 'Product Listed'
      redirect_to about_path
    else
      render 'static_pages/home'
    end
  end

  def show
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:item_name, :item_type, :description, :price)
  end
end
