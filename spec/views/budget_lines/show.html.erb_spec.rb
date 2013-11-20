require 'spec_helper'

describe "budget_lines/show" do
  before(:each) do
    @budget_line = assign(:budget_line, stub_model(BudgetLine,
      :phase => 1,
      :position => 2,
      :item_decription => "Item Decription",
      :unit_definition => "Unit Definition",
      :unit_cost => 1.5,
      :quantity => 3,
      :cost => 1.5,
      :budget => nil,
      :resource => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Item Decription/)
    rendered.should match(/Unit Definition/)
    rendered.should match(/1.5/)
    rendered.should match(/3/)
    rendered.should match(/1.5/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
