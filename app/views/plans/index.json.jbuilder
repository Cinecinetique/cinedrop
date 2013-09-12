json.array!(@plans) do |plan|
  json.extract! plan, :name, :description, :features, :price, :trial_period, :paid_instalments, :is_available
  json.url plan_url(plan, format: :json)
end