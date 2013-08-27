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
		parameters = {
			name: "a name",
		}
		document = Document.new(parameters)
		expect { document.save! }.to_not raise_error
	end

	it "should not save if data_host is not in the list of accepted services" do 
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
		}
		parameters_ok[1] = {
			name: "a name",
			data_host: "youtube",
			data_ref: "yyy",
		}		
		document = Document.new(parameters_notok)
		expect { document.save! }.to raise_error(ActiveRecord::RecordInvalid)

		parameters_ok.each do |parameter_ok|
			document = Document.new(parameter_ok)
			expect { document.save! }.to_not raise_error
		end

	end
end
