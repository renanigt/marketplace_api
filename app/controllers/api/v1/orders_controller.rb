module Api
  module V1
    class OrdersController < ApplicationController
      before_action :check_authorization

      def index
        render json: current_user.orders
      end

      def show
        @order = Order.find(params[:id])
        render json: @order
      end

      def create
        @order = current_user.orders.build(order_params)

        if @order.save
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(product_ids: [])
      end
    end
  end
end
