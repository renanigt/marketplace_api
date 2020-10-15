module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, except: :create
      before_action :check_user, except: :create

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy!
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def check_user
        head :forbidden unless @user.id == current_user&.id
      end
    end
  end
end
