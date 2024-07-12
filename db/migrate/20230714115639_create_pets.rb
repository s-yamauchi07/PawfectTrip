class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string     :name,      null: false
      t.string     :breed,     null: false
      t.integer    :size_id,   null: false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
