require "fnordmetric"

FnordMetric.namespace :gallery do
  toplist_gauge :popular_images, title: "Popular Images"

  event :view_image do
    observe :popular_images, data[:url]
  end
end

FnordMetric::Web.new(port: 4242)
FnordMetric::Worker.new
FnordMetric.run