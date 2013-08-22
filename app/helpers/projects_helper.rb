module ProjectsHelper
		def vimeo_thumbnail(document)
		vimeo_video_json_url     = "http://vimeo.com/api/v2/video/%s.json" % document.data_ref   # API call

		# Parse the JSON and extract the thumbnail_large url
		thumbnail_image_location = JSON.parse(open(vimeo_video_json_url).read).first['thumbnail_small'] rescue nil
	end
end
