class Stream::Destination::Photos < Stream::Destination

  def construct_post_query
    posts = ::StatusMessage
    debugger
    if user.present? 
      posts = posts.owned_or_visible_by_user(user)
    else
      posts = posts.all_public
    end
    posts.tagged_with(tag_name)
  end

  def posts_with_photos
    posts = []
    @posts_with_photos ||= ::StatusMessage.tagged_with(tag_name).includes(:photos).order('photos.created_at').map do |sm| 
      posts << sm if sm.photos.blank? == false
    end
    return posts
  end

end

