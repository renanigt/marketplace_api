module Api
  module V1
    class ProductsController < ApplicationController
      before_action :check_authorization, only: [:create, :update, :destroy]
      before_action :set_product, only: [:show, :update, :destroy]

      def index
        render json: Product.all.order(:name), status: :ok
      end

      def list
        render json: Product.where(user_id: params[:user_id]), status: :ok
      end

      def create
        @product = current_user.products.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @product, status: :ok
      end

      def update
        if @product.update(product_params)
          render json: @product, status: :ok
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        head :no_content
      end

      private

      def product_params
        params.require(:product).permit(:name, :description, :price)
      end

      def set_product
        @product = Product.find(params[:id])
      end
    end
  end
end
