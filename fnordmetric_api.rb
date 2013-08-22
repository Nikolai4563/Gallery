#require 'fnordmetric'
#
#FnordMetric.namespace :gallery do
#  hide_active_users
#  toplist_gauge :popular_images, title: "Popular Images"
#
#  gauge :image_views_per_second
#  event :view_image do
#    observe :popular_images, data[:url]
#  end
#end
#
#FnordMetric::Web.new(port: 4242)
#FnordMetric::Worker.new
#FnordMetric.run
#
#
#
