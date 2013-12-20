require 'spec_helper'

describe PaypalNotification do

  it "should enable ssl if IPN url is https" do
  	url = "https://foo.com"
  	request = ""
  	stub_request(:post, "http://foo.com:443/").
         with(:headers => {'Accept'=>'*/*', 'Content-Length'=>'0', 'User-Agent'=>'My custom user agent'}).
         to_return(:status => 200, :body => "INVALID", :headers => {})

  	expect_any_instance_of(Net::HTTP).to receive(:use_ssl=).with(true)
  	PaypalNotification.validate_IPN_notification(url, request)
  end

  it "should not enable ssl if IPN url is http" do
  	url = "http://foo.com"
  	request = ""
  	stub_request(:post, "http://foo.com").
         with(:headers => {'Accept'=>'*/*', 'Content-Length'=>'0', 'User-Agent'=>'My custom user agent'}).
         to_return(:status => 200, :body => "INVALID", :headers => {})

  	expect_any_instance_of(Net::HTTP).to receive(:use_ssl=).with(false)
  	PaypalNotification.validate_IPN_notification(url, request)
  end

end
