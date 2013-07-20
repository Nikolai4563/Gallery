ActiveAdmin.register_page "Parse" do
  page_action :ex, :method => :post do

    link = params[:parse][:url]

    if !params[:send_image].blank?
      array_img = params[:send_image]
      logger.info "*"*100
      logger.info array_img
      array_img.each_with_index do |link, index|
        curl =  Curl.get(link)
        tempfile = Tempfile.new(Time.now.to_f.to_s)
        tempfile.write curl.body_str.force_encoding('utf-8')
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => link)
        Image.create!(:url=>uploaded_file, :category_id =>params[:category_id])
      end
    end

    if !link.blank?
      http = Curl.get(link) do |http|
        http.headers['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20100101 Firefox/21.0'
      end
      html = Nokogiri::HTML(open(link,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2'), nil, 'utf-8')
      img_array = Array.new

      html.css("img").each_with_index do |link, index|
        img_array[index] = link['src']
      end
      @img_array = img_array
      @category = Category.all


      render :layout => 'active_admin'
    end


  end
  page_action :save_img, :method => :post do
    array_img = params[:send_image]
    array_img.each_with_index do |link|
      curl =  Curl.get(link)
      tempfile = Tempfile.new(Time.now.to_f.to_s)
      tempfile.write curl.body_str.force_encoding('utf-8')
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => link)
      Image.create!(:url=>uploaded_file, :category_id =>params[:category_id])
    end
    render :json => {}, :layout => false

  end
  content do
    semantic_form_for :parse, :builder => ActiveAdmin::FormBuilder do |f|
      f.input :url, :as => :string
    end


  end


end