require 'spec_helper'

describe "proposals/edit" do
  before(:each) do
    @proposal = assign(:proposal, stub_model(Proposal,
      :topic => "MyString",
      :premise => "MyString",
      :message => "MyString",
      :outline => "MyString",
      :conflict => "MyString",
      :audience_bias => "MyString",
      :characters => "MyString",
      :interviews => "MyString",
      :time => "MyString",
      :time => "MyString",
      :time => "MyString",
      :form => "MyString",
      :style => "MyString",
      :resolution => "MyString",
      :differentiation => "MyString",
      :marketing => "MyString",
      :status => "MyString",
      :project => nil
    ))
  end

  it "renders the edit proposal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", proposal_path(@proposal), "post" do
      assert_select "input#proposal_topic[name=?]", "proposal[topic]"
      assert_select "input#proposal_premise[name=?]", "proposal[premise]"
      assert_select "input#proposal_message[name=?]", "proposal[message]"
      assert_select "input#proposal_outline[name=?]", "proposal[outline]"
      assert_select "input#proposal_conflict[name=?]", "proposal[conflict]"
      assert_select "input#proposal_audience_bias[name=?]", "proposal[audience_bias]"
      assert_select "input#proposal_characters[name=?]", "proposal[characters]"
      assert_select "input#proposal_interviews[name=?]", "proposal[interviews]"
      assert_select "input#proposal_time[name=?]", "proposal[time]"
      assert_select "input#proposal_time[name=?]", "proposal[time]"
      assert_select "input#proposal_time[name=?]", "proposal[time]"
      assert_select "input#proposal_form[name=?]", "proposal[form]"
      assert_select "input#proposal_style[name=?]", "proposal[style]"
      assert_select "input#proposal_resolution[name=?]", "proposal[resolution]"
      assert_select "input#proposal_differentiation[name=?]", "proposal[differentiation]"
      assert_select "input#proposal_marketing[name=?]", "proposal[marketing]"
      assert_select "input#proposal_status[name=?]", "proposal[status]"
      assert_select "input#proposal_project[name=?]", "proposal[project]"
    end
  end
end
