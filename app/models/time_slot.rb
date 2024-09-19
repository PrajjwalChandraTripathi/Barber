class TimeSlot < ApplicationRecord
  belongs_to :shop
  has_many :bookings
  validate :show_time_slot

  def self.available
    where.not(id: Booking.pluck(:time_slot_id))
  end

  def available?
    shop.bookings.empty?
  end
  
  private
 
  def show_time_slot
    shop_opening = shop.opening_time
    shop_closing = shop.closing_time

    if shop_opening < start_time || shop_closing > end_time
      errors.add(:base,"can't book at this time")
    end
  end

end
