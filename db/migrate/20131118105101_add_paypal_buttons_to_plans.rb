class AddPaypalButtonsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :paypal_dev_button, :string
    add_column :plans, :paypal_test_button, :string
    add_column :plans, :paypal_prod_button, :string
  end
end
