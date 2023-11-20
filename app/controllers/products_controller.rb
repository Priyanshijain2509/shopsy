# frozen_string_literal: true

# Product controller for ceating and manipulating products
class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy show]
  # to display all products
  def index
    @products = current_user.seller? ? current_user.products : Product.all
    products = @products.includes(:orders)

    render json: {
      products: products.as_json(include: :orders),
      current_user: current_user.as_json
    }
  end

  def all_products; end

  # create new product
  def create
    @product = current_user.products.new(product_params)

    if @product.save
      render json: { success: true, message: 'Product successfully created!',
      product: @product }, status: :created
    else
      render json: { success: false, errors: @product.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  # for new product form
  def new
    user_id = params[:user_id]
    @product = User.find(user_id).products.new
  end

  # to edit the product details
  def edit
    render json: { product: @product }
  end

  # to destroy the product
  def destroy
    @product.destroy
    render json: { message: 'Product deleted successfully' }, status: :ok
  end

  # to update the product details
  def update
    if @product.update(product_params)
      flash[:notice] = 'Product updated'
      render json: { message: 'Product edited successfully' }, status: :ok
    else
      flash[:alert] = "Product couldn't be updated"
      render 'edit'
    end
  end

  def show
    render json: { product: @product }
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
