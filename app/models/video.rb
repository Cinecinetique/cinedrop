class Video < Document
      HOST_TYPES = [ "vimeo", "youtube" ]
	has_attached_file :data, 
                        :styles => { :mobile => {:geometry => "400x300", :format => 'mp4', :streaming => true}, 
                                     :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 1 }, 
                                     :poster => { :geometry => "400x300#", :format => 'jpg', :time => 1 }},
                        :convert_options => { :mobile => "-movflags faststart"},
			      :default_url => "/images/:style/missing.png",
				:processors => [ :ffmpeg ]
      validates_attachment :data,
                           :size => { :in => 0..100.megabytes }
      before_post_process :media?

	def self.content_types
      [ 'application/x-mp4',
            'video/mpeg',
            'video/quicktime',
            'video/x-la-asf',
            'video/x-ms-asf',
            'video/x-msvideo',
            'video/x-sgi-movie',
            'video/x-flv',
            'flv-application/octet-stream',
            'video/3gpp',
            'video/3gpp2',
            'video/3gpp-tt',
            'video/BMPEG',
            'video/BT656',
            'video/CelB',
            'video/DV',
            'video/H261',
            'video/H263',
            'video/H263-1998',
            'video/H263-2000',
            'video/H264',
            'video/JPEG',
            'video/MJ2',
            'video/MP1S',
            'video/MP2P',
            'video/MP2T',
            'video/mp4',
            'video/MP4V-ES',
            'video/MPV',
            'video/mpeg4',
            'video/mpeg4-generic',
            'video/nv',
            'video/parityfec',
            'video/pointer',
            'video/raw',
            'video/rtx',
            'video/x-matroska',
            'video/webm',
            'video/ogg',
            'video/x-ms-wmv' ]
  end


end
