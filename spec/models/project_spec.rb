require "spec_helper"
require 'rails/test_help'


describe Project, "When a new project is created" do 

	before(:each) do
	  @parameters = {
	  	name: "The Eternal XYZ",
	  	created_by: 34,
	  }
	end

	after(:each) do
	  @parameters = nil
	end


	it "should be valid if name is unique" do

		project = Project.new(@parameters)
		project.valid?.should be_true

	end

	it "should not save project with already existing name" do
		parameters = {
			name: "MyString",
		}
		project = Project.new(parameters)
		project.valid?.should be_false
	end

	it "should knows how to create a S3 bucket in Singapore" do

		project = Project.new(@parameters)
		project_cycle = ProjectCycle.new(project)
		fake_s3 = double('fake_s3')
		buckets = double('buckets')
		bucket_name_on_s3  = double('bucket_name_on_s3')
		AWS::S3.should_receive(:new).and_return(fake_s3)
		fake_s3.should_receive(:buckets).twice.and_return(buckets) #once for checking the name, once for create the bucket
		buckets.should_receive(:[]).and_return(bucket_name_on_s3)
		AWS::S3::Bucket.stub(:new).and_return(bucket_name_on_s3)
		bucket_name_on_s3.should_receive(:exists?).and_return(false)
		buckets.should_receive(:create).with("#{Rails.env}-#{project.created_by}-the-eternal-xyz",{:location_constraint => "ap-southeast-1"}).and_return(true)
		project_cycle.send(:create_bucket).should be_true	

	end



end