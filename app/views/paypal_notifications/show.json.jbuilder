json.extract! @paypal_notification, :transaction_type, :transaction_id, :parent_transaction_id, :message, :payment_status, :receiver_email, :buyer_email, :status, :custom, :created_at, :updated_at
