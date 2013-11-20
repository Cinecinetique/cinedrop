class CreateBudgetLines < ActiveRecord::Migration
  def change
    create_table :budget_lines do |t|
      t.integer :phase
      t.integer :position
      t.string :item_decription
      t.string :unit_definition
      t.float :unit_cost
      t.integer :quantity
      t.float :cost
      t.references :budget, index: true
      t.references :resource, index: true

      t.timestamps
    end
  end
end
