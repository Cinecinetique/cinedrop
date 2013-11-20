json.array!(@budgets) do |budget|
  json.extract! budget, :preprod_cost, :prod_cost, :postprod_cost, :outreach_cost, :marketing_distribution_cost, :administrative_cost, :total_cost, :cost_currency, :status, :project_id
  json.url budget_url(budget, format: :json)
end