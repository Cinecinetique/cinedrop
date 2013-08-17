class Audio < Document
	has_attached_file :data, 
                      :styles => { :compressed => {:geometry => "400x300", :format => 'mp3', :streaming => true},
                                   :ogg_compressed => {:geometry => "400x300", :format => 'ogg', :streaming => true} },
                      :convert_options => { :mobile => "-movflags faststart"},
				      :default_url => "/images/:style/missing.png",
				      :processors => [ :ffmpeg ]
					  
    validates_attachment :data, :presence => true,
                           :size => { :in => 0..70.megabytes }
    before_post_process :media?

	def self.content_types
      [ 'audio/basic','audio/L24','audio/mp3','audio/mp4','audio/mpeg','audio/ogg','audio/vorbis','audio/vnd.rn-realaudio','audio/vnd.wave','audio/webm','audio/wav','audio/x-wav' ]
  end
end