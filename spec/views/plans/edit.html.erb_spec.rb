require 'spec_helper'

describe "plans/edit" do
  before(:each) do
    @plan = assign(:plan, stub_model(Plan,
      :name => "MyString",
      :description => "MyString",
      :features => "MyString",
      :price => 1.5,
      :trial_period => 1,
      :paid_instalments => 1,
      :is_available => false
    ))
  end

  it "renders the edit plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do
      assert_select "input#plan_name[name=?]", "plan[name]"
      assert_select "input#plan_description[name=?]", "plan[description]"
      assert_select "input#plan_features[name=?]", "plan[features]"
      assert_select "input#plan_price[name=?]", "plan[price]"
      assert_select "input#plan_trial_period[name=?]", "plan[trial_period]"
      assert_select "input#plan_paid_instalments[name=?]", "plan[paid_instalments]"
      assert_select "input#plan_is_available[name=?]", "plan[is_available]"
    end
  end
end
