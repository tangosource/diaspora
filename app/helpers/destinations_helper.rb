module DestinationsHelper

  def destination_image_tag(destination, size=nil)
    size ||= :thumb_small
    "<img alt=\"#{h(destination.title)}\" class=\"avatar\" data-destination_id=\"#{destination.id}\" src=\"#{destination.photo_url}\" title=\"#{h(destination.title)}\">".html_safe
  end

  def destination_image_link(destination, opts={})
    return "" if destination.nil?
    if opts[:to] == :photos
      link_to destination_image_tag(destination, opts[:size]), destination_photos_path(destination)
    else
      "<a href='#{destination_href(destination)}' class='#{opts[:class]}' #{ ("target=" + opts[:target]) if opts[:target]}>
      #{destination_image_tag(destination, opts[:size])}
      </a>".html_safe
    end
  end

  def destination_href(destination, opts={})
    Rails.application.routes.url_helpers.destination_path(destination,opts)
  end

  def destination_link(destination, opts={})
    opts[:class] ||= ""
    remote_or_hovercard_link = "/destinations/#{destination.id}".html_safe
    "<a data-hovercard='#{remote_or_hovercard_link}' href='#{destination_href(destination)}' class='#{opts[:class]}' #{ ("target=" + opts[:target]) if opts[:target]}>#{h(destination.title)}</a>".html_safe
  end
end
