class AddMaxValuesToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :max_projects, :integer
    add_column :plans, :max_users, :integer
  end
end
