class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string   :title,            null: false
      t.datetime :departure_date,   null: false
      t.datetime :return_date,      null: false
      t.integer :departure_id,      null: false
      t.integer :destination_id,    null: false
      t.integer :companion_id,      null: false
      t.references :dog,            null: false
      t.string :tag
      t.references :user,           null: false
      t.timestamps
    end
  end
end
