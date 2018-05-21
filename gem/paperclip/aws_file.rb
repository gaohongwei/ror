def image
  begin
    image = S3Store.new(params[:upload][:image]).store
    #...
  rescue Exception => e
    #...
  end
end

fname = 'alogo.txt'
bucket.objects[fname].write('Text', acl: :public_read)


class S3Store
  BUCKET = "app-uploads".freeze

  def initialize file
    @file = file
    @s3 = AWS::S3.new
    @bucket = @s3.buckets[BUCKET]
  end

  def store
    @obj = @bucket.objects[filename].write(@file.tempfile, acl: :public_read)
    self
  end

  def url
    @obj.public_url.to_s
  end

  private
  
  def filename
    @filename ||= @file.original_filename.gsub(/[^a-zA-Z0-9_\.]/, '_')
  end
end



  def rename(style_name = :txt)
    s3 = AWS::S3.new
    bucket ||= s3.buckets[image.bucket_name]
    obj = bucket.objects[image.s3_object(style_name).key]
    new_obj = "#{bucket}/alogo.txt"
    new_obj = "alogo.txt"

    obj.move_to(new_obj, acl:'public-read') # rename file to new name with public read acl.

  obj = S3::Object.new(bucket, style_name, client: s3)
  obj.move_to('target-bucket/target-key')

  end
