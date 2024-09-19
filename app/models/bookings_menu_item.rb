class BookingsMenuItem < ApplicationRecord
    belongs_to :booking
    belongs_to :menu_item
end
