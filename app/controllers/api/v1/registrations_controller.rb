class Api::V1::RegistrationsController < ApplicationController
    respond_to :json

    # POST /api/v1/users
    def create
        debugger
      user = User.new(user_params)
      if user.save
        render json: { message: 'User created successfully', user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end
