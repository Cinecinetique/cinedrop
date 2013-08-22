module DocumentsHelper
	def signed_url(document)
		# policy = AWS::STS::Policy.new
		# policy.allow(:actions => :any, :resource => :any)
		# session = AWS::STS.new.new_federated_session('mysession', :policy => policy)

		#s3 = AWS::S3.new(session.credentials)
		s3 = AWS::S3.new()
		url = s3.buckets[ENV['AWS_BUCKET']].objects[document.data.path[1..-1]].url_for(:read)
		url.to_s
	end

end
