class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.integer :phone_number
      t.boolean :promoted
      t.string :location
      t.datetime :opening_time
      t.datetime :closing_time
      t.references :user, null: false, foreign_key: true
      t.integer :gender_specification, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
