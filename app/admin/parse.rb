ActiveAdmin.register_page "Parse" do
  page_action :ex, :method => :post do

    link = params[:parse][:url]

    if !link.blank?
      http = Curl.get(link) do |http|
        http.headers['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20100101 Firefox/21.0'
      end
      html = Nokogiri::HTML(http.body_str)
      img_array = Array.new
      html.xpath("//img").each_with_index do |link, index|
        # logger.info link['src']
        img_array[index] = link['src']
        #curl =  Curl.get(link['src'])
        #tempfile = Tempfile.new(Time.now.to_f.to_s)
        #tempfile.write curl.body_str.force_encoding('utf-8')
        #uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => link['src'])
         #Image.create!(:title=>params[:file_addr],:filename=>uploaded_file)

        #@pic = Image.create!(:url=>uploaded_file)

          #category = Category.find_or_create_by_name('download')
          #category.images.create(:url => uploaded_file)
      end
      @img_array = img_array
      @category = Category.all


      render :layout => 'active_admin'
    end
  end
  content do
    semantic_form_for :parse, :builder => ActiveAdmin::FormBuilder do |f|
      f.input :url, :as => :string
    end



  end


end