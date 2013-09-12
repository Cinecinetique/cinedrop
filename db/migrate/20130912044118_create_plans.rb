class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.string :features
      t.float :price
      t.integer :trial_period
      t.integer :paid_instalments
      t.boolean :is_available

      t.timestamps
    end
  end
end
