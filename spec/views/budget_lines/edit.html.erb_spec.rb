require 'spec_helper'

describe "budget_lines/edit" do
  before(:each) do
    @budget_line = assign(:budget_line, stub_model(BudgetLine,
      :phase => 1,
      :position => 1,
      :item_decription => "MyString",
      :unit_definition => "MyString",
      :unit_cost => 1.5,
      :quantity => 1,
      :cost => 1.5,
      :budget => nil,
      :resource => nil
    ))
  end

  it "renders the edit budget_line form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", budget_line_path(@budget_line), "post" do
      assert_select "input#budget_line_phase[name=?]", "budget_line[phase]"
      assert_select "input#budget_line_position[name=?]", "budget_line[position]"
      assert_select "input#budget_line_item_decription[name=?]", "budget_line[item_decription]"
      assert_select "input#budget_line_unit_definition[name=?]", "budget_line[unit_definition]"
      assert_select "input#budget_line_unit_cost[name=?]", "budget_line[unit_cost]"
      assert_select "input#budget_line_quantity[name=?]", "budget_line[quantity]"
      assert_select "input#budget_line_cost[name=?]", "budget_line[cost]"
      assert_select "input#budget_line_budget[name=?]", "budget_line[budget]"
      assert_select "input#budget_line_resource[name=?]", "budget_line[resource]"
    end
  end
end
