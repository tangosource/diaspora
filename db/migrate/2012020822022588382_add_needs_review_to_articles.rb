class AddNeedsReviewToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :needs_review, :boolean, :default => true
  end

  def self.down
    remove_column :articles, :needs_review
  end
end
