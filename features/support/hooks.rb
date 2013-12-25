Before do |scenario|
  # The +scenario+ argument is optional, but if you use it, you can get the title,
  # description, or name (title + description) of the scenario that is about to be
  # executed.
  	Warden.test_mode!
	Rails.logger.debug "Starting scenario: #{scenario.title}"
	if scenario.title =~ /paypal/ || scenario.title =~ /subscription notificiation/
  	RestClient.post "http://localhost:4578/doubles", "fullpath=/cgi-bin/webscr%3Fcmd=_notify-validate&verb=POST&content=VERIFIED&status=200"
	end
end



After do |scenario|
	Warden.test_reset! 
	Rails.logger.debug "Finishing scenario: #{scenario.title}"
  	if scenario.title =~ /can.*create.*project/
		visit ("/projects/")
		within('tr', text: 'MyProject') do
			click_link("Delete")
			page.driver.browser.switch_to.alert.accept
		end
	end
	if scenario.title =~ /can.*project/
		cleanup_buckets("development-9-myproject")
	end
	if scenario.title =~ /paypal/ || scenario.title =~ /payment/
		RestClient.delete "http://localhost:4578/doubles/all"
	end
end