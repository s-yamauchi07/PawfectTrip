class CreateHotelLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :hotel_likes do |t|
      t.references  :user,  null:false, foreign_key: true
      t.references  :hotel, null:false, foreign_key: true
      t.timestamps
    end
  end
end
