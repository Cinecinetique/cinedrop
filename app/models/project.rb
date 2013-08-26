class Project < ActiveRecord::Base
	has_many :documents
	has_many :workers, dependent: :destroy
	before_create :create_bucket
	validates :name, :uniqueness => true
	accepts_nested_attributes_for :workers, :allow_destroy => true

	def bucket_name
		"#{Rails.env}-#{created_by}-#{name.parameterize}"
	end

	private

	def create_bucket
		bucket_name = "#{Rails.env}-#{created_by}-#{name.parameterize}"
		s3 = AWS::S3.new
		bucket_name_on_s3 = s3.buckets[bucket_name]
		if bucket_name_on_s3.exists?
			false
		else
			bucket = s3.buckets.create(bucket_name, {:location_constraint => "ap-southeast-1"})
		end

	end
end
