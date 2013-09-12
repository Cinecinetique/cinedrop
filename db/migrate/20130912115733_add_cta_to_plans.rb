class AddCtaToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :call_to_action, :string
  end
end
