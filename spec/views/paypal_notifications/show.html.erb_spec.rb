require 'spec_helper'

describe "paypal_notifications/show" do
  before(:each) do
    @paypal_notification = assign(:paypal_notification, stub_model(PaypalNotification,
      :transaction_type => "Transaction Type",
      :transaction_id => "Transaction",
      :parent_transaction_id => "Parent Transaction",
      :message => "MyText",
      :payment_status => "Payment Status",
      :receiver_email => "Receiver Email",
      :buyer_email => "Buyer Email",
      :status => "Status",
      :custom => "Custom"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Transaction Type/)
    rendered.should match(/Transaction/)
    rendered.should match(/Parent Transaction/)
    rendered.should match(/MyText/)
    rendered.should match(/Payment Status/)
    rendered.should match(/Receiver Email/)
    rendered.should match(/Buyer Email/)
    rendered.should match(/Status/)
    rendered.should match(/Custom/)
  end
end
