class Shop < ApplicationRecord
  belongs_to :user
  has_many :ratings
  has_many :time_slots
  has_many :menu_items
  has_many :bookings
  has_many :bookings, through: :time_slots
  
  after_initialize :default_shop_status_and_promoted, if: :new_record?

  enum gender_specification: { male: 0, female: 1, unisex: 2 }
  enum status: { reviewing: 0, accepted: 1, rejected: 2 }
  
  def create_time_slots_for_day(date)
    start_time = date.beginning_of_day
    end_time = date.end_of_day

    while start_time < end_time
      time_slots.create(start_time: start_time, end_time: start_time + 30.minutes)
      start_time += 30.minutes
    end
  end
  
  private

  def default_shop_status_and_promoted
    self.status ||= :reviewing 
    self.promoted ||= false
  end
end
