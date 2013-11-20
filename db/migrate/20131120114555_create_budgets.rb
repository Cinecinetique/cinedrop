class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.float :preprod_cost
      t.float :prod_cost
      t.float :postprod_cost
      t.float :outreach_cost
      t.float :marketing_distribution_cost
      t.float :administrative_cost
      t.float :total_cost
      t.string :cost_currency
      t.string :status
      t.references :project, index: true

      t.timestamps
    end
  end
end
