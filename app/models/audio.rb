class Audio < Document
	has_attached_file :data, 
                    :styles => { :compressed => {:format => 'mp3'},
                                 :ogg_compressed => {:format => 'ogg'} },
        				    :default_url => "/images/:style/missing.png",
        				    :processors => [ :audio_processor ]
					  
    validates_attachment :data, :presence => true,
                           :size => { :in => 0..70.megabytes }
    before_post_process :media?

	def self.content_types
      [ 'audio/basic','audio/L24','audio/mp3','audio/mp4','audio/mpeg','audio/ogg','audio/vorbis','audio/vnd.rn-realaudio','audio/vnd.wave','audio/webm','audio/wav','audio/x-wav' ]
  end
end