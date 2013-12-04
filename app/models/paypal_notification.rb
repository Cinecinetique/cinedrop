class PaypalNotification < ActiveRecord::Base
	
	def self.validate_IPN_notification(raw)
      uri = URI.parse(::IPN_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      #http.use_ssl = true
      response = http.post(uri.request_uri, raw,
                           'Content-Length' => "#{raw.size}",
                           'User-Agent' => "My custom user agent"
                         ).body
    end
end
