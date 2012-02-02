class Stream::Destination < Stream::Tag
  def related_articles
    @related_articles ||= Magazine::Article.tagged_with(tag_name)
  end

  def related_places
    @related_places ||= ::Place.tagged_with(tag_name)
  end

  def related_photos
  end

end
