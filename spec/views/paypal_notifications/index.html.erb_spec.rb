require 'spec_helper'

describe "paypal_notifications/index" do
  before(:each) do
    assign(:paypal_notifications, [
      stub_model(PaypalNotification,
        :transaction_type => "Transaction Type",
        :transaction_id => "Transaction",
        :parent_transaction_id => "Parent Transaction",
        :message => "MyText",
        :payment_status => "Payment Status",
        :receiver_email => "Receiver Email",
        :buyer_email => "Buyer Email",
        :status => "Status",
        :custom => "Custom"
      ),
      stub_model(PaypalNotification,
        :transaction_type => "Transaction Type",
        :transaction_id => "Transaction",
        :parent_transaction_id => "Parent Transaction",
        :message => "MyText",
        :payment_status => "Payment Status",
        :receiver_email => "Receiver Email",
        :buyer_email => "Buyer Email",
        :status => "Status",
        :custom => "Custom"
      )
    ])
  end

  it "renders a list of paypal_notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Transaction Type".to_s, :count => 2
    assert_select "tr>td", :text => "Transaction".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Transaction".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Status".to_s, :count => 2
    assert_select "tr>td", :text => "Receiver Email".to_s, :count => 2
    assert_select "tr>td", :text => "Buyer Email".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Custom".to_s, :count => 2
  end
end
