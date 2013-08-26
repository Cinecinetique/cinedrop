class Image < Document
  	has_attached_file :data, 
                      :styles => { :medium => ["400x300>",:jpg], :thumb => ["120x90>",:jpg] },
			          :default_url => "/images/:style/missing.png",
			          :bucket => proc { |attachment| attachment.instance.project.bucket_name }
    validates_attachment :data, :presence => true,
                           :size => { :in => 0..40.megabytes }

  def self.content_types
    ['image/gif','image/jpg','image/jpeg','image/pjpg','image/png','image/tiff','image/svg+xml']
  end


end
