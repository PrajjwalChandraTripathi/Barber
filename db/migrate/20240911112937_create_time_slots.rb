class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.string :start_time
      t.string :end_time
      t.boolean :booked
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
