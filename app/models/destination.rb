class Destination < ActiveRecord::Base
  validates_presence_of :permalink

  acts_as_taggable_on :tags

  def self.search(query,limit=5)

    sql, tokens = self.search_query_string(query)
    self.where(sql, *tokens)
  end

  def self.search_query_string(query)
    query = query.downcase
    like_operator = postgres? ? "ILIKE" : "LIKE"

    where_clause = <<-SQL
      destinations.permalink #{like_operator} ? OR
      destinations.title #{like_operator} ?
    SQL

    q_tokens = []
    q_tokens[0] = query.to_s.strip.gsub(/(\s|$|^)/) { "%#{$1}" }
    q_tokens[1] = q_tokens[0].gsub(/\s/,'').gsub('%','')
    q_tokens[1] << "%"

    [where_clause, q_tokens]
  end
  
  def as_json( opts = {} )
    opts ||= {}
    json = {
      :id => self.id,
      :name => self.title,
      :avatar => self.photo_url,
      :url => "/destinations/#{self.id}",
    }
    json.merge!(:tags => self.profile.tags.map{|t| "##{t.name}"}) if opts[:includes] == "tags"
    json
  end
end
