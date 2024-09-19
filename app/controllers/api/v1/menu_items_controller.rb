class Api::V1::MenuItemsController < ApplicationController
    before_action :set_menu_item, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def index
        shop = Shop.find(params[:shop_id])
        @menu_items = shop.menu_items
        render json: @menu_items
    end

    def show
        render json: @menu_item
    end

    def create
        shop = Shop.find(params[:shop_id])
        @menu_item = shop.menu_items.new(menu_item_params)
        if @menu_item.save
            render json: @menu_item, status: :created
        else
            render json: @menu_item.errors, status: :unprocessable_entity
        end
    end

    def update
        if @menu_item.update(menu_item_params)
            render json: @menu_item
        else
            render json: @menu_item.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @menu_item.destroy
        head :no_content
    end

    private

    def set_menu_item
        shop = Shop.find(params[:shop_id])
        @menu_item = shop.menu_items.find(params[:id])
    end

    def menu_item_params
        params.require(:menu_item).permit(:service, :price)
    end
end
