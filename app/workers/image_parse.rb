class ImageParse
  @queue = :image_parse_queue
  def self.perform(resque_params)
    resque_params[0].each_with_index do |link|
      curl = Curl.get(link[1][0])
      tempfile = Tempfile.new(Time.now.to_f.to_s)
      tempfile.write curl.body_str.force_encoding('utf-8')
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => link[1][0])
      Image.create!(:url=>uploaded_file, :category_id =>resque_params[1], :title => link[1][1])
    end
  end

end