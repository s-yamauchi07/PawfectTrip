class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string   :title,            null: false
      t.datetime :departure_date,   null: false
      t.datetime :destination_date, null: false
      t.integer :departure_id,      null: false
      t.integer :destination_id,    null: false
      t.integer :companion_id,      null: false
      t.referenes :dog_id:          null: false
      t.references :tag,            null: false
      t.references :user,           null: false
      t.timestamps
    end
  end
end
