json.array!(@paypal_notifications) do |paypal_notification|
  json.extract! paypal_notification, :transaction_type, :transaction_id, :parent_transaction_id, :message, :payment_status, :receiver_email, :buyer_email, :status, :custom
  json.url paypal_notification_url(paypal_notification, format: :json)
end