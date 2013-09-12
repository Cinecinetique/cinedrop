require 'spec_helper'

describe "plans/index" do
  before(:each) do
    assign(:plans, [
      stub_model(Plan,
        :name => "Name",
        :description => "Description",
        :features => "Features",
        :price => 1.5,
        :trial_period => 1,
        :paid_instalments => 2,
        :is_available => false
      ),
      stub_model(Plan,
        :name => "Name",
        :description => "Description",
        :features => "Features",
        :price => 1.5,
        :trial_period => 1,
        :paid_instalments => 2,
        :is_available => false
      )
    ])
  end

  it "renders a list of plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Features".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
