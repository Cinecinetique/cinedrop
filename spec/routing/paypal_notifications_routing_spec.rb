require "spec_helper"

describe PaypalNotificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/paypal_notifications").should route_to("paypal_notifications#index")
    end

    it "routes to #new" do
      get("/paypal_notifications/new").should route_to("paypal_notifications#new")
    end

    it "routes to #show" do
      get("/paypal_notifications/1").should route_to("paypal_notifications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paypal_notifications/1/edit").should route_to("paypal_notifications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paypal_notifications").should route_to("paypal_notifications#create")
    end

    it "routes to #update" do
      put("/paypal_notifications/1").should route_to("paypal_notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paypal_notifications/1").should route_to("paypal_notifications#destroy", :id => "1")
    end

  end
end
