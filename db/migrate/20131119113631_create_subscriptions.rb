class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :amount
      t.string :currency
      t.integer :billing_frequency
      t.integer :status
      t.references :user, index: true
      t.references :plan, index: true
      t.float :initial_amount
      t.string :initial_currency
      t.integer :initial_billing_frequency
      t.float :previous_amount
      t.string :previous_currency
      t.integer :previous_billing_frequency
      t.datetime :last_plan_price_change_date

      t.timestamps
    end
  end
end
