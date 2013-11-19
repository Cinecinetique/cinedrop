json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :start_date, :end_date, :amount, :currency, :billing_frequency, :status, :user_id, :plan_id, :initial_amount, :initial_currency, :initial_billing_frequency, :previous_amount, :previous_currency, :previous_billing_frequency, :last_plan_price_change_date
  json.url subscription_url(subscription, format: :json)
end