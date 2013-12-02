class AddRecurringPaymentIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :recurring_payment_id, :string
    add_column :subscriptions, :recurring_payment_provider, :string
    add_column :subscriptions, :recurring_payment_id_label, :string
  end
end
