class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :subscription, index: true
      t.belongs_to :worker, index: true
      t.datetime :settlement_date
      t.string :service
      t.float :amount
      t.string :currency

      t.timestamps
    end
  end
end
