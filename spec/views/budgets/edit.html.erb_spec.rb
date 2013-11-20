require 'spec_helper'

describe "budgets/edit" do
  before(:each) do
    @budget = assign(:budget, stub_model(Budget,
      :preprod_cost => 1.5,
      :prod_cost => 1.5,
      :postprod_cost => 1.5,
      :outreach_cost => 1.5,
      :marketing_distribution_cost => 1.5,
      :administrative_cost => 1.5,
      :total_cost => 1.5,
      :cost_currency => "MyString",
      :status => "MyString",
      :project => nil
    ))
  end

  it "renders the edit budget form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", budget_path(@budget), "post" do
      assert_select "input#budget_preprod_cost[name=?]", "budget[preprod_cost]"
      assert_select "input#budget_prod_cost[name=?]", "budget[prod_cost]"
      assert_select "input#budget_postprod_cost[name=?]", "budget[postprod_cost]"
      assert_select "input#budget_outreach_cost[name=?]", "budget[outreach_cost]"
      assert_select "input#budget_marketing_distribution_cost[name=?]", "budget[marketing_distribution_cost]"
      assert_select "input#budget_administrative_cost[name=?]", "budget[administrative_cost]"
      assert_select "input#budget_total_cost[name=?]", "budget[total_cost]"
      assert_select "input#budget_cost_currency[name=?]", "budget[cost_currency]"
      assert_select "input#budget_status[name=?]", "budget[status]"
      assert_select "input#budget_project[name=?]", "budget[project]"
    end
  end
end
