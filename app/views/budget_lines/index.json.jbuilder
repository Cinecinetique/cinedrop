json.array!(@budget_lines) do |budget_line|
  json.extract! budget_line, :phase, :position, :item_decription, :unit_definition, :unit_cost, :quantity, :cost, :budget_id, :resource_id
  json.url budget_line_url(budget_line, format: :json)
end