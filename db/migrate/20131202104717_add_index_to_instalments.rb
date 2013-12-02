class AddIndexToInstalments < ActiveRecord::Migration
  def change
  		rename_column :instalments, :status, :payment_status
  		add_column :instalments, :status, :integer
	  	add_index :instalments, [:transaction_id, :status], :unique => true
  end
end
