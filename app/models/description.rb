class Description < ActiveRecord::Base

  validates_presence_of :title, :location, :summary


  def image_url(size = :thumb_large)
    result = if size == :thumb_medium && self[:image_url_medium]
               self[:image_url_medium]
             elsif size == :thumb_small && self[:image_url_small]
               self[:image_url_small]
             else
               self[:image_url]
             end
    result || '/images/user/default.png'
  end

  def title_sanitized
    self.title.gsub(/([\s]){1,}/,'_').gsub(/[\W]{1,}/,'').downcase
  end
end

