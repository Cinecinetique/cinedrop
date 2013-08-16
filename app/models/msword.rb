class Msword < Document
	belongs_to :project
	has_attached_file :data, 
				          :default_url => "/images/:style/missing.png"
	validates_attachment :data, :presence => true,
	                           :size => { :in => 0..40.megabytes }
	before_post_process :media?

	def self.content_types
		['application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document']
	end
end