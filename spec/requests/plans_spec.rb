require 'spec_helper'

describe "Plans" do
  describe "GET /plans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get plans_path
      response.status.should be(302)
    end
  end
end