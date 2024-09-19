class Api::V1::ShopsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :index, :specific_user_shop]
    skip_before_action :authenticate_user!, only: [:create, :update, :destroy, :index, :specific_user_shop]
    
    def index
        @shops = Shop.all
        render json: { shops: @shops }, status: :ok
    end
    
    def specific_user_shop
        user = User.find(params[:user_id])
        @shops = user.shops
            render json: { shops: @shops }, status: :ok
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'User not found' }, status: :not_found
    end
    
    def create
        user = User.find(params[:user_id])
        @shop = user.shops.build(shop_params)
        if user.role == client
            if @shop.save
                render json: { message: 'Shop created successfully', shop: @shop }, status: :created
            else
                render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: {errors: "Only a client can create a shop"}
        end
    end
    
    def update
        user = User.find(params[:user_id])
        shop = user.shops.find(params[:id])
        @shop = shop.update(shop_params)
        if @shop
            render json: { message: 'Shop updated successfully', shop: @shop }, status: :created
        else
            render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:user_id])
        shop = user.shops.find(params[:id])
        @shop = shop.destroy
            render json: {  message: 'Shop deleted successfully' }, status: :ok
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'User not found' }, status: :not_found
    end
    
    private

    def shop_params
        params.require(:shop).permit(:name, :phone_number, :status, :promoted, :location, :gender_specification)
    end
end