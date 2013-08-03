class CategorySweeper < ActionController::Caching::Sweeper
  observe Category
  def sweep(category)
    expire_fragment 'subscribes_category'
    expire_fragment 'menu'
    logger.info '+'*100
  end
  alias_method :after_update,  :sweep
  alias_method :after_create,  :sweep
  alias_method :after_destroy, :sweep
end