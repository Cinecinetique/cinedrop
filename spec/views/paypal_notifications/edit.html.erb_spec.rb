require 'spec_helper'

describe "paypal_notifications/edit" do
  before(:each) do
    @paypal_notification = assign(:paypal_notification, stub_model(PaypalNotification,
      :transaction_type => "MyString",
      :transaction_id => "MyString",
      :parent_transaction_id => "MyString",
      :message => "MyText",
      :payment_status => "MyString",
      :receiver_email => "MyString",
      :buyer_email => "MyString",
      :status => "MyString",
      :custom => "MyString"
    ))
  end

  it "renders the edit paypal_notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paypal_notification_path(@paypal_notification), "post" do
      assert_select "input#paypal_notification_transaction_type[name=?]", "paypal_notification[transaction_type]"
      assert_select "input#paypal_notification_transaction_id[name=?]", "paypal_notification[transaction_id]"
      assert_select "input#paypal_notification_parent_transaction_id[name=?]", "paypal_notification[parent_transaction_id]"
      assert_select "textarea#paypal_notification_message[name=?]", "paypal_notification[message]"
      assert_select "input#paypal_notification_payment_status[name=?]", "paypal_notification[payment_status]"
      assert_select "input#paypal_notification_receiver_email[name=?]", "paypal_notification[receiver_email]"
      assert_select "input#paypal_notification_buyer_email[name=?]", "paypal_notification[buyer_email]"
      assert_select "input#paypal_notification_status[name=?]", "paypal_notification[status]"
      assert_select "input#paypal_notification_custom[name=?]", "paypal_notification[custom]"
    end
  end
end
