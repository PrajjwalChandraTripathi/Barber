class Api::V1::BookingsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!
        before_action :set_shop, only: [:new, :create]
        before_action :ensure_customer

        def ensure_customer
          @@user = User.find(params[:user_id])
          unless @@user.role == 'customer'
            redirect_to root_path, alert: 'Only customers can make bookings.'
          end
        end

        def index
          @bookings = Booking.all
          render json: {booking: @bookings}
        end
        
        def show
          @booking = @@user.bookings.find(params[:id])
          render json: {booking: @bookings}
        end

        def new
          @time_slots = @shop.time_slots.available # Only show available time slots
          @booking = Booking.new
        end
      
        def create
          @shop = Shop.find(params[:shop_id])
          @time_slot = @shop.time_slots.find(params[:time_slot_id])
          menu_item_ids = Array(params[:booking][:menu_item_ids])
          @menu_items = @shop.menu_items.where(id: menu_item_ids)
              
          if @time_slot.available? && @menu_items.present?
            @booking = @@user.bookings.build(shop: @shop, time_slot: @time_slot, menu_items: @menu_items)
        
            if @booking.save
              @time_slot.update(booked: true) # Mark the time slot as booked
              render json: { message: 'Booking successful' }, status: :created
            else
              render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { error: 'Time slot or menu items are not available' }, status: :unprocessable_entity
          end
        end
        
      
        private
      
        def set_shop
          @shop = Shop.find(params[:shop_id])
        end
      
        def booking_params
          params.require(:booking).permit(:user_id, :shop_id, :time_slot_id, :status, menu_item_ids: [])
        end
      
end
