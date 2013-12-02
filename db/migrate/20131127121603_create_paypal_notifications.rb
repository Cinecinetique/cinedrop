class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.string :transaction_type
      t.string :transaction_id
      t.string :parent_transaction_id
      t.text :message
      t.string :payment_status
      t.string :receiver_email
      t.string :buyer_email
      t.string :status
      t.string :custom

      t.timestamps
    end
  end
end
