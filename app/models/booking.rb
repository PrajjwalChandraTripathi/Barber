class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :time_slot
  has_many :bookings_menu_items
  has_many :menu_items, through: :bookings_menu_items
  validate :time_slot_available
  before_create :set_default_status

  private
  def set_default_status
    self.status ||= 'scheduled'
  end
  def time_slot_available
    errors.add(:time_slot, "is already booked") unless time_slot.available?
  end
end
