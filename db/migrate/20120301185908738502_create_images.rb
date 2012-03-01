class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :article_id, :null => false
      t.string :url, :null => false
      t.timestamps
    end
    add_column :articles, :excerpt, :text
  end

  def self.down
		drop_table :images
    remove_column :articles, :excerpt
	end
end
