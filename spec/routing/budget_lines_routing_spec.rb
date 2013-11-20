require "spec_helper"

describe BudgetLinesController do
  describe "routing" do

    it "routes to #index" do
      get("/budget_lines").should route_to("budget_lines#index")
    end

    it "routes to #new" do
      get("/budget_lines/new").should route_to("budget_lines#new")
    end

    it "routes to #show" do
      get("/budget_lines/1").should route_to("budget_lines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/budget_lines/1/edit").should route_to("budget_lines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/budget_lines").should route_to("budget_lines#create")
    end

    it "routes to #update" do
      put("/budget_lines/1").should route_to("budget_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/budget_lines/1").should route_to("budget_lines#destroy", :id => "1")
    end

  end
end
