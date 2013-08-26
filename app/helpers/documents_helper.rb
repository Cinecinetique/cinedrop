module DocumentsHelper
	require 'cgi'
	
	def signed_url_for(style, document)
		s3 = AWS::S3.new()
		if s3.buckets[document.project.bucket_name].exists?
			url = s3.buckets[document.project.bucket_name].objects[document.data.path(style)[1..-1]].url_for(:read)
			url.to_s
		end
	end

	def google_viewer_url(url)
		gv_url = "http://docs.google.com/viewer?url=#{CGI.escape(url)}&embedded=true"
	end


end
