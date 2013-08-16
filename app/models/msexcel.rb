class Msexcel < Document
	belongs_to :project
	has_attached_file :data, 
				          :default_url => "/images/:style/missing.png"
	validates_attachment :data, :presence => true,
	                           :size => { :in => 0..40.megabytes }
	before_post_process :media?

	def self.content_types
		['application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
	end
end