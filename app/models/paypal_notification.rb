class PaypalNotification < ActiveRecord::Base
	
	def self.validate_IPN_notification(url, raw)
      uri = URI.parse(url)
      Rails.logger.info "About to connect to Paypal IPN: #{uri.host}:#{uri.port}"
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      #http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      if uri.scheme == "https"
        http.use_ssl= true
      else
        http.use_ssl= false
      end

      response = http.post(uri.request_uri, raw,
                           'Content-Length' => "#{raw.size}",
                           'User-Agent' => "My custom user agent"
                         ).body     
    end
end
