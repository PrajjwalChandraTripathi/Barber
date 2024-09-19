# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create]
      before_action :authenticate_user!, except: [:create]

      # POST /api/v1/users
      def create
        @user = User.new(user_params)

        # Ensure the role is either 'customer' or 'client'
        unless %w[customer client admin].include?(@user.role)
          return render json: { error: 'Invalid role' }, status: :unprocessable_entity
        end

        if @user.save
          render json: { message: 'User created successfully', user: @user }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :name, :location, :phone_number)
      end
    end
  end
end
