 module AwsHelper

  def cleanup_buckets(bucket)
    s3 = AWS::S3.new
    bucket_name_on_s3 = s3.buckets[bucket]
    if bucket_name_on_s3.exists?
      bucket_name_on_s3.delete
    end
  end

end