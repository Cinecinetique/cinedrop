class CreateIpnMessages < ActiveRecord::Migration
  def change
    create_table :ipn_messages do |t|
      t.string :status
      t.string :txn_id
      t.string :parent_txn_id
      t.string :txn_type
      t.string :message
      t.string :receiver_email
      t.string :buyer_email

      t.timestamps
    end
  end
end
