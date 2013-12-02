class AddIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, [:amount, :status, :user_id, :plan_id], :unique => true, :name => 'uniq_subscr_idx'
  end
end
