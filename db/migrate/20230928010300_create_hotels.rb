class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.integer   :hotel_num,  null: false
      t.timestamps
    end
  end
end
