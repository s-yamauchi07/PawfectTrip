class CreatePlanTags < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_tags do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
