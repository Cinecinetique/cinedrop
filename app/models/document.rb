class Document < ActiveRecord::Base
      belongs_to :project
	has_attached_file :data, 
                        :styles => lambda { |a| a.instance.video? ? ({:mobile => {:geometry => "400x300", :format => 'mp4', :streaming => true}, :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 1 }, :poster => { :geometry => "400x300#", :format => 'jpg', :time => 1 }}) : ({ :medium => ["400x300>",:jpg], :thumb => ["100x100>",:jpg] }) },
                        :convert_options => { :mobile => "-movflags faststart",
                                              :thumb => "-flatten"},
			      :default_url => "/images/:style/missing.png",
				:processors => lambda { |a| a.video? ? [ :ffmpeg ] : [ :thumbnail ] }
      validates_attachment :data, :presence => true,
                           :size => { :in => 0..40.megabytes }
      before_post_process :media?

	def video?
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
            'video/rtx' ].include?(data.content_type)
  end

  def image?
      !(data_content_type =~ /^image.*/).nil?
  end 

  def audio?
      !(data_content_type =~ /^audio.*/).nil?
  end 

  def pdf?
      data_content_type == 'application/pdf'
  end

  def media?
      video? || image? || audio? || pdf?
  end

  def xls?
      data_content_type == 'application/vnd.ms-excel'
  end

  def xlsx?
      data_content_type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end

  def doc?
      data_content_type == 'application/msword'
  end

  def docx?
      data_content_type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  end




end
