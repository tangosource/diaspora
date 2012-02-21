class Stream::Destination < Stream::Tag
  RELATED_PLACES_TAGS = %w( hotels restaurants clubs attractions parks museums )

  #attr_accessor :names

  #def initialize(user, tag_name, opts={})
    #self.tag_name = tag_name
    #self.people_page = opts[:page] || 1
    #super(user, opts)
  #end

  def related_articles
    @related_articles ||= Magazine::Article.tagged_with(names, :any => true)
  end

  def related_places
    places = {}
    RELATED_PLACES_TAGS.each do |tag|
      places[tag] = related_places_each(tag)
    end
    return places
  end

  def related_destinations
    ::Destination.tagged_with(names)
  end

  def related_places_each(key)
    raise 'invalid key' unless RELATED_PLACES_TAGS.include?(key)
    ::Place.tagged_with(key).tagged_with(names, :any => true)
  end

end
