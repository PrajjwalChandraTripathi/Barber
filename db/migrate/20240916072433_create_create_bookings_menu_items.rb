class CreateCreateBookingsMenuItems < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings_menu_items do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bookings_menu_items, [:booking_id, :menu_item_id], unique: true
  end
end
