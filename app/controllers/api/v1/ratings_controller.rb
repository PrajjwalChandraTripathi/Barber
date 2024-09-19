class Api::V1::RatingsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :index, :show]
    skip_before_action :authenticate_user!, only: [:create, :index, :show]
    
    def index
        shop = Shop.find(params[:shop_id])
        @ratings = shop.ratings
        render json: { ratings: @ratings }, status: :ok
    end
    
    def show
        shop = Shop.find(params[:shop_id])
        rating = shop.ratings
        @ratings = rating.find(params[:id])
            render json: { ratings: @ratings }, status: :ok
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'User not found' }, status: :not_found
    end
    
    def create
        shop = Shop.find(params[:shop_id])  # Get shop from route params
        @rating = shop.ratings.build(rating_params)
    
        if @rating.save
            render json: { message: 'Rating created successfully', rating: @rating }, status: :created
        else
            render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
        end
    end
      
    
    # def update
    #     user = User.find(params[:user_id])
    #     shop = user.shops.find(params[:id])
    #     rating = shop.rating
    #     @shop = shop.update(shop_params)
    #     if @shop
    #         render json: { message: 'Shop updated successfully', shop: @shop }, status: :created
    #     else
    #         render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    #     end
    # end

    # def destroy
    #     user = User.find(params[:user_id])
    #     shop = user.shops.find(params[:id])
    #     @shop = shop.destroy
    #         render json: {  message: 'Shop deleted successfully' }, status: :ok
    #     rescue ActiveRecord::RecordNotFound
    #         render json: { error: 'User not found' }, status: :not_found
    # end
    
    private

    def rating_params
        params.require(:rating).permit(:value, :review)
    end
end
