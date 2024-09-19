class MenuItem < ApplicationRecord
  belongs_to :shop
  has_many :bookings_menu_items
  has_many :bookings, through: :bookings_menu_items
  def self.ransackable_associations(auth_object = nil)
    ["shop"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "price", "service", "shop_id", "updated_at"]
  end
end
