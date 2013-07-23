class ImageSweeper < ActionController::Caching::Sweeper
  observe Image
  def sweep(image)
    expire_page image_path
    expire_page image_path(image)
    expire_path '/'
    FileUtils.rm_rf "#{page_cache_directory}/image/page"
  end

  alias_method :after_update,  :sweep
  alias_method :after_create,  :sweep
  alias_method :after_destroy, :sweep

end