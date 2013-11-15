module UserProfile
	def user_details_for_a(type_of_user)
		if type_of_user == "Subscriber"
			{email:"vera_ccq@rijam.sent.as", password:"12345678"}
		elsif type_of_user == "Member"
			{email:"john_ccq@rijam.sent.as", password:"12345678"}
		end
	end
end