class Pdf < Document
	has_attached_file :data, 
                      :styles => { :medium => ["400x300>",:jpg], :thumb => ["100x100>",:jpg] } ,
                      :convert_options => {:thumb => "-flatten"},
			          :default_url => "/images/:style/missing.png"
      validates_attachment :data, :presence => true,
                           :size => { :in => 0..40.megabytes }

	def self.content_types
	    ['application/pdf']
	end
end