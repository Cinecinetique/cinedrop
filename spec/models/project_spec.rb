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
		fake_s3 = mock()
		buckets = mock()
		bucket_name_on_s3  = mock()
		AWS::S3.expects(:new).returns(fake_s3)
		fake_s3.expects(:buckets).returns(buckets).twice #once for checking the name, once for create the bucket
		buckets.expects(:[]).returns(bucket_name_on_s3)
		AWS::S3::Bucket.stubs(:new).returns(bucket_name_on_s3)
		bucket_name_on_s3.expects(:exists?).returns(false)
		buckets.expects(:create).with("#{Rails.env}-#{project.created_by}-the-eternal-xyz",{:location_constraint => "ap-southeast-1"}).returns(true)
		project.send(:create_bucket).should be_true	

	end

	it "should create a S3 bucket before create" do
		Project._create_callbacks.select { |cb| cb.kind.eql?(:before) }
			.collect(&:filter)
			.include?(:create_bucket)
			.should be_true
	end

	it "should fail to save project if the bucket creation fails" do
		project = Project.new(@parameters)
		fake_s3 = mock()
		buckets = mock()
		bucket_name_on_s3  = mock()
		AWS::S3.expects(:new).returns(fake_s3)
		fake_s3.expects(:buckets).returns(buckets)
		buckets.expects(:[]).returns(bucket_name_on_s3)
		AWS::S3::Bucket.stubs(:new).returns(bucket_name_on_s3)
		bucket_name_on_s3.expects(:exists?).returns(true)
		project.send(:create_bucket).should be_false	
	end


end