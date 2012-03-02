class AddDatePublishedToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :date_published, :datetime
  end

  def self.down
    remove_column :articles, :date_published
  end
end
