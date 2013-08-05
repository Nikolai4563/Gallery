ActiveAdmin.register_page "Parse" do
  page_action :ex, :method => :post do

    link = params[:parse][:url]

    if !link.blank?
      http = Curl.get(link) do |http|
        http.headers['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20100101 Firefox/21.0'
      end
      html = Nokogiri::HTML(open(link,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2'), nil, 'utf-8')
      img_array = Array.new
      site_url = /^(?:http:\/\/www\.|www\.|http:\/\/)?([a-zA-Z0-9.]+)/i.match(link)
      html.css("img").each_with_index do |link, index|
        img_array[index] = (/^(?:http:\/\/www\.|www\.|http:\/\/)?([a-zA-Z0-9.]+)/i.match(link['src']).blank?) ? [site_url[0] + link['src'], link['alt']] : [link['src'], link['alt']]
      end
      @img_array = img_array
      @category = Category.all
      render :layout => 'active_admin'
    end
  end
  page_action :save_img, :method => :post do
    array_img = params[:send_image]
    array_img.each_with_index do |link|
      curl = Curl.get(link[1][0])
      tempfile = Tempfile.new(Time.now.to_f.to_s)
      tempfile.write curl.body_str.force_encoding('utf-8')
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => link[1][0])
      Image.create!(:url=>uploaded_file, :category_id =>params[:category_id], :title => link[1][1])
      expire_fragment 'subscribes_category'
      expire_fragment 'menu'
    end
    render :json => {}, :layout => false
  end
  content do
    semantic_form_for :parse, :builder => ActiveAdmin::FormBuilder do |f|
      f.inputs "Parse page" do
        f.input :url, :as => :string
      end
      f.actions
    end
  end
end