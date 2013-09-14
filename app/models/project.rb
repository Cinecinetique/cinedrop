class Project < ActiveRecord::Base
	has_many :documents
	has_many :scenes,  ->  { order "position" }, inverse_of: :project
	has_many :workers, dependent: :destroy
	#before_create :create_bucket
	validates :name, :uniqueness => true
	accepts_nested_attributes_for :workers, :allow_destroy => true

	def bucket_name
		"#{Rails.env}-#{created_by}-#{name.parameterize}"
	end

	def team
		workers.map { |w| w.user}
	end

end
