module DocumentsHelper
	require 'cgi'
	
	def signed_url_for(style, document)
		if Cinecinetique::STORAGE == :s3
			s3 = AWS::S3.new()
			url = s3.buckets[document.project.bucket_name].objects[document.data.path(style)[1..-1]].url_for(:read)
			url.to_s
		else
			document.data.url(style)
		end
	end

	def google_viewer_url(url)
		gv_url = "http://docs.google.com/viewer?url=#{CGI.escape(url)}&embedded=true"
	end


end
