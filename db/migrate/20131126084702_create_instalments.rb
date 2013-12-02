class CreateInstalments < ActiveRecord::Migration
  def change
    create_table :instalments do |t|
      t.string :transaction_id
      t.string :status
      t.integer :billing_period
      t.boolean :is_trial
      t.datetime :payment_date
      t.float :amount
      t.string :currency
      t.references :subscription, index: true

      t.timestamps
    end
  end
end
