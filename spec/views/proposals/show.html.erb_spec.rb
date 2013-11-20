require 'spec_helper'

describe "proposals/show" do
  before(:each) do
    @proposal = assign(:proposal, stub_model(Proposal,
      :topic => "Topic",
      :premise => "Premise",
      :message => "Message",
      :outline => "Outline",
      :conflict => "Conflict",
      :audience_bias => "Audience Bias",
      :characters => "Characters",
      :interviews => "Interviews",
      :time => "Time",
      :time => "Time",
      :time => "Time",
      :form => "Form",
      :style => "Style",
      :resolution => "Resolution",
      :differentiation => "Differentiation",
      :marketing => "Marketing",
      :status => "Status",
      :project => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Topic/)
    rendered.should match(/Premise/)
    rendered.should match(/Message/)
    rendered.should match(/Outline/)
    rendered.should match(/Conflict/)
    rendered.should match(/Audience Bias/)
    rendered.should match(/Characters/)
    rendered.should match(/Interviews/)
    rendered.should match(/Time/)
    rendered.should match(/Time/)
    rendered.should match(/Time/)
    rendered.should match(/Form/)
    rendered.should match(/Style/)
    rendered.should match(/Resolution/)
    rendered.should match(/Differentiation/)
    rendered.should match(/Marketing/)
    rendered.should match(/Status/)
    rendered.should match(//)
  end
end
