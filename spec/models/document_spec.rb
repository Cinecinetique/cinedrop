require "spec_helper"
require 'rails/test_help'


describe Document, "When a new document is created without file attachement" do 

	it "should not save if the name is not supplied" do
		parameters = {
			name: nil,
			created_by: 34,
		}
		document = Document.new(parameters)
		expect { document.save! }.to raise_error(ActiveRecord::RecordInvalid)
	end
	
	it "should not save if the data host is supplied but not the data ref" do 
		parameters = {
			name: "a name",
			data_host: "xxx",
		}
		document = Document.new(parameters)
		expect { document.save! }.to raise_error(ActiveRecord::RecordInvalid)
	end

	it "should not save if the data ref is supplied but not the data host" do 
		parameters = {
			name: "a name",
			data_ref: "xxx",
		}
		document = Document.new(parameters)
		expect { document.save! }.to raise_error(ActiveRecord::RecordInvalid)
	end

	it "should save if the name is supplied"  do 
		user = mock()
		changes_count = mock()
		parameters = {
			name: "a name",
		}
		changes_count.expects(:success?).returns(false)
		Firebase.expects(:get).with("changes_count").returns(changes_count)
		document = Document.new(parameters)
		document.expects(:notify_users).returns(true)
		expect { document.save! }.to_not raise_error
	end

	it "should not save if data_host is not in the list of accepted services" do 
		user = mock()
		changes_count = mock()
		parameters_notok = {
			name: "a name",
			data_host: "xxx",
			data_ref: "yyy",
		}
		parameters_ok = []
		parameters_ok[0] = {
			name: "a name",
			data_host: "vimeo",
			data_ref: "yyy",
			changed_by: 4,
		}
		parameters_ok[1] = {
			name: "a name",
			data_host: "youtube",
			data_ref: "yyy",
			changed_by: 4,
		}		
		document = Document.new(parameters_notok)
		expect { document.save! }.to raise_error(ActiveRecord::RecordInvalid)

		parameters_ok.each do |parameter_ok|
			changes_count.expects(:success?).returns(false)
			Firebase.expects(:get).with("changes_count").returns(changes_count)
			document = Document.new(parameter_ok)
			document.expects(:notify_users).returns(true)
			expect { document.save! }.to_not raise_error
		end
	end
	it "should not trigger a notification to firebase if query for changes count is not sucessful"

	it "should trigger a push of change notification to firebase if changes count exists"

end

describe Document, "When the document changes" do 
	describe "for the first time (creation)" do
		it "should send an email to the project's team" do
			user = mock()
			changes_count = mock()
			parameters = {
				name: "a name",
			}
			changes_count.expects(:success?).returns(false)
			Firebase.expects(:get).with("changes_count").returns(changes_count)
			document = Document.new(parameters)
			document.name = "The Continuity log"
			document.updated_at = Time.now
			document.created_by = 435
			project = mock()
			creator = mock()
			document.expects(:project).returns(project)
			user_one = User.new(:email => "a@f.com", :name => "Foo")
			user_two = User.new(:email => "b@f.com", :name => "Bar")
			project.expects(:team).returns([user_one, user_two])
			mail = mock()
			NotificationMailer.expects(:changes_notification).with(document,user_one).returns(mail)
			NotificationMailer.expects(:changes_notification).with(document,user_two).returns(mail)
			mail.expects(:deliver).twice

			expect { document.save! }.to_not raise_error
		end
	end
end
