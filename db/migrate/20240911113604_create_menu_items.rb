class CreateMenuItems < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_items do |t|
      t.string :gender
      t.string :service
      t.decimal :price
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
