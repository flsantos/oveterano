# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def stylesheets(*files)
    content_for(:stylesheets) { stylesheet_link_tag(*files) }
  end

  def javascripts(*files)
    content_for(:javascripts) { javascript_include_tag(*files) }
  end
end
