require "spec_helper"
require 'rails/test_help'

describe User, "When no project information is supplied" do 
	it "should create a user record" do
		parameters = {
			email: "foo@bar.com",
			password: "secret",
			password_confirmation: "secret"
		}
		user = User.new(parameters)
		user_count = User.count
		worker_count = Worker.count
		user.save
		User.count.should eql(user_count+1)
		Worker.count.should eql(worker_count)
	end
end

describe User, "When project information is supplied" do
	fixtures :projects
	
	it "should create a user record and a worker record" do

		project = projects(:one)
		parameters = {
			email: "foo@bar.com",
			password: "secret",
			password_confirmation: "secret",
			role: "Make Up Artist",
			department: "Art",
			project_id: project.id
		}
		user = User.new(parameters)
		user_count = User.count
		worker_count = Worker.count
		user.save
		User.count.should eql(user_count+1)
		Worker.count.should eql(worker_count+1)
	end

end
