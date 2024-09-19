class Api::V1::TimeSlotsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    
    def index
        shop = Shop.find(params[:shop_id])
        @time_slot= shop.time_slots
        render json: {time_slot: @time_slot}
    end

    def create
        shop = Shop.find(params[:shop_id])
        @time_slot = shop.time_slots.new(slot_params)
        if @time_slot.save
            render json: {time_slot: @time_slot}, status: :ok
        else
            render json: {error: "Time slot not available"}
        end
    end

    private

    def slot_params
        params.require(:time_slot).permit(:shop_id, :start_time, :end_time, :booked)
    end
end
