class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string    :name,       null: false
      t.string    :prefecture, null: false
      t.string    :address,    null: false
      t.float     :lat,        null: false
      t.float     :lng,        null: false
      t.integer   :hotel_num,  null: false
      t.timestamps
    end
  end
end
