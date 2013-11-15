Rails.env="development"

# After do |scenario|
# 	if scenario == 'Preparing a file to be sent to a partner'
# 		visit ("/projects/1/")
# 		within "#document_my-cucumber-document" do
# 			click_link("Delete")
# 			page.driver.browser.switch_to.alert.accept
# 		end
# 	end
# 	if scenario =~ /can.*create.*project/
# 		visit ("/projects/")
# 		within('tr', text: 'MyProject') do
# 			click_link("Delete")
# 			page.driver.browser.switch_to.alert.accept
# 		end
# 	end
# end

Before do |scenario|
  # The +scenario+ argument is optional, but if you use it, you can get the title,
  # description, or name (title + description) of the scenario that is about to be
  # executed.
  Rails.logger.debug "Starting scenario: #{scenario.title}"
end



After do |scenario|
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
end