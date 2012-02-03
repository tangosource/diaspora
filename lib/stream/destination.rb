class Stream::Destination < Stream::Tag
  def related_articles
    @related_articles ||= Magazine::Article.tagged_with(tag_name)
  end

  def related_places
    @related_places ||= ::Place.tagged_with(tag_name)
  end

  def posts_with_photos
    posts = []
    @posts_with_photos ||= ::StatusMessage.tagged_with(tag_name).includes(:photos).order('photos.created_at').map do |sm| 
      posts << sm if sm.photos.blank? == false
    end
    return posts
  end

end
