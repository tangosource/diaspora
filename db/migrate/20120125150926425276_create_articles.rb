class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.references :blogger, :polymorphic => true
      t.integer :comments_count, :default => 0, :null => false
      t.timestamps
    end
    add_index :articles, [:blogger_type, :blogger_id]
  end
  def self.down
		drop_table :articles
	end
end
