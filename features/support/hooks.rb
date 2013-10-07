After do |scenario|
	if scenario == 'Preparing a file to be sent to a partner'
		visit ("/projects/1/")
		within "#document_my-cucumber-document" do
			click_link("Delete")
			page.driver.browser.switch_to.alert.accept
		end
	end
end