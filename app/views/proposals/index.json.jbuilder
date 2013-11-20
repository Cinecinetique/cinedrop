json.array!(@proposals) do |proposal|
  json.extract! proposal, :topic, :premise, :message, :outline, :conflict, :audience_bias, :characters, :interviews, :preprod_start_date, :time, :preprod_end_date, :time, :prod_start_date, :time, :prod_end_date, :postprod_start_date, :postprod_end_date, :form, :style, :resolution, :differentiation, :marketing, :status, :project_id
  json.url proposal_url(proposal, format: :json)
end