ActiveAdmin.register Image do
  index do
    column :url do |image|
      link_to image_tag(image.url, width: 150, height: 150), admin_image_path(image)
    end
    column :category, :sortable => 'category_id'
    column :likes_count
    column :comments_count
    default_actions
  end
  controller do
    def scoped_collection
      Image.includes(:category)
    end
    def show
      @image = Image.find(params[:id])
      @comments = @image.comments.includes(:commentable)
    end
  end
  show do |img|
    render 'admin/images/show'
  end
  filter :url
end