class Destination < ActiveRecord::Base
  validates_presence_of :permalink

  acts_as_taggable
  acts_as_taggable_on :names

  before_save :build_search_string

  def self.search(query,limit=5)

    sql, tokens = self.search_query_string(query)
    self.where(sql, *tokens)
  end

  def self.search_query_string(query)
    query = query.downcase
    like_operator = postgres? ? "ILIKE" : "LIKE"

    where_clause = <<-SQL
      destinations.search_string #{like_operator} ? OR
      destinations.permalink #{like_operator} ?
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

  def to_param
    "#{id}-#{title.gsub(' ','-').gsub('.','')}"
  end

  def build_search_string
    self.search_string = [title.downcase, name_list.to_a.map(&:downcase)].join(' ')
  end

  def tag_string
    self.tag_list.map{|tag| "#" + tag}.join(" ")
  end

  def alternative_names_tag_string
    self.search_string.split(" ").map{|tag| '#' + tag}.join(' ')
  end
end
