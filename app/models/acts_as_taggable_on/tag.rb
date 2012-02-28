class ActsAsTaggableOn::Tag

  def self.extract_from_params(tags)
    tags = tags.gsub(/([\#]){1,}/,'').split(',')
    tags.map {|tag| tag.strip.gsub(' ', '_')}.join(',')
  end

  def followed_count
   @followed_count ||= TagFollowing.where(:tag_id => self.id).count
  end

  def self.tag_text_regexp
    @@tag_text_regexp ||= (RUBY_VERSION.include?('1.9') ? "[[:alnum:]]_-" : "\\w-")
  end

  def self.autocomplete(name)
    where("name LIKE ?", "#{name.downcase}%")
  end

  def self.normalize(name)
    if name =~ /^#?<3/
      # Special case for love, because the world needs more love.
      '<3'
    elsif name
      name.gsub(/[^#{self.tag_text_regexp}]/, '').gsub(' ', '_').downcase
    end
  end
end
