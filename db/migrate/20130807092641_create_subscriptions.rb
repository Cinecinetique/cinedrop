class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :project, index: true
      t.string :method
      t.integer :time_capacity
      t.integer :people_capacity
      t.float :amount
      t.string :currency

      t.timestamps
    end
  end
end
