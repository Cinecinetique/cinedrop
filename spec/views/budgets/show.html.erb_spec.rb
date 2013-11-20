require 'spec_helper'

describe "budgets/show" do
  before(:each) do
    @budget = assign(:budget, stub_model(Budget,
      :preprod_cost => 1.5,
      :prod_cost => 1.5,
      :postprod_cost => 1.5,
      :outreach_cost => 1.5,
      :marketing_distribution_cost => 1.5,
      :administrative_cost => 1.5,
      :total_cost => 1.5,
      :cost_currency => "Cost Currency",
      :status => "Status",
      :project => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Cost Currency/)
    rendered.should match(/Status/)
    rendered.should match(//)
  end
end
