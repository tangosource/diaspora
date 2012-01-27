class Place < ActiveRecord::Base
  include ROXML
  include Encryptor::Public
  include Diaspora::Guid

  has_one :description, :dependent => :destroy
  delegate :title, :image_url, :to => :description
  accepts_nested_attributes_for :description

  validates_presence_of :description
  validates_associated :description
  validates :diaspora_handle, :uniqueness => true

  before_save :auto_diaspora_handle

  has_one :place_mention
  has_many :posts, :through=> :place_mention

  def name
    title
  end

  #attr_accessible 

  def initialize(attributes={})
    super
    self.description ||= self.build_description
  end

  def auto_diaspora_handle
    self.diaspora_handle ||= "#{description.title_sanitized}#{User.diaspora_id_host}"
  end

  def self.search(query,limit=5)

    sql, tokens = self.search_query_string(query)
    self.where(sql, *tokens)
  end

  def self.search_query_string(query)
    query = query.downcase
    like_operator = postgres? ? "ILIKE" : "LIKE"

    where_clause = <<-SQL
      places.url #{like_operator} ? OR
      places.diaspora_handle #{like_operator} ?
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
      :name => self.name,
      :avatar => self.description.image_url(:thumb_medium),
      :handle => self.diaspora_handle,
      :url => "/places/#{self.id}",
    }
    json.merge!(:tags => self.profile.tags.map{|t| "##{t.name}"}) if opts[:includes] == "tags"
    json
  end

end



