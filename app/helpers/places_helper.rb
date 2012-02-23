module PlacesHelper

  def place_image_tag(place, size=nil)
    size ||= :thumb_small
    "<img alt=\"#{h(place.title)}\" class=\"avatar\" data-place_id=\"#{place.id}\" src=\"#{place.description.image_url(size)}\" title=\"#{h(place.title)}\">".html_safe
  end

  def place_image_link(place, opts={})
    return "" if place.nil? || place.description.nil?
    if opts[:to] == :photos
      link_to place_image_tag(place, opts[:size]), place_photos_path(place)
    else
      "<a href='#{place_href(place)}' class='#{opts[:class]}' #{ ("target=" + opts[:target]) if opts[:target]}>
      #{place_image_tag(place, opts[:size])}
      </a>".html_safe
    end
  end

  def place_href(place, opts={})
    Rails.application.routes.url_helpers.place_path(place,opts)
  end

  def place_link(place, opts={})
    opts[:class] ||= ""
    remote_or_hovercard_link = "/places/#{place.id}".html_safe
    "<a data-hovercard='#{remote_or_hovercard_link}' href='#{place_href(place)}' class='#{opts[:class]}' #{ ("target=" + opts[:target]) if opts[:target]}>#{h(place.title)}</a>".html_safe
  end

end
