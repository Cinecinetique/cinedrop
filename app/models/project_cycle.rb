class ProjectCycle
  attr_accessor :project

  def initialize(project)
    @project = project
  end


	def create
		if self.project.save
		  create_bucket
		end
	end

	private

	def create_bucket
		bucket_name = "#{Rails.env}-#{@project.created_by}-#{@project.name.parameterize}"
		s3 = AWS::S3.new
		bucket_name_on_s3 = s3.buckets[bucket_name]
		if bucket_name_on_s3.exists?
			false
		else
			bucket = s3.buckets.create(bucket_name, {:location_constraint => "ap-southeast-1"})
		end
	end

end