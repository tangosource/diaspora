class Stream::Destination < Stream::Tag

  RELATED_PLACES_TAGS = %w( hotels restaurants clubs attractions parks museums )

  def related_articles
    @related_articles ||= Magazine::Article.tagged_with(tag_name)
  end

  def related_places
    places = {}
    RELATED_PLACES_TAGS.each do |tag|
      places[tag] = related_places_each(tag)
    end
    return places
  end

  def related_destinations
    ::Destination.tagged_with(tag_name)
  end

  def related_places_each(key)
    raise 'invalid key' unless RELATED_PLACES_TAGS.include?(key)
    ::Place.tagged_with([tag_name,key], :match_all=>true)
  end

end
