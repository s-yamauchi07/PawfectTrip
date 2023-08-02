class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries do |t|
      t.datetime :date,                   null: false
      t.string :place,                null: false
      t.integer :transportation_id,   null: false
      t.text    :memo
      t.references :plan, null:false, foreign_key: true
      t.timestamps
    end
  end
end
