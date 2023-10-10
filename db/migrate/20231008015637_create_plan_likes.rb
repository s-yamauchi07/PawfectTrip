class CreatePlanLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.timestamps
    end
  end
end
