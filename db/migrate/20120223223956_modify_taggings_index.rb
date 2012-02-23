class ModifyTaggingsIndex < ActiveRecord::Migration
  def self.up
    remove_index :taggings, :name => 'index_taggings_uniquely'
    add_index :taggings, [:taggable_id, :taggable_type, :tag_id, :context], :unique => true, :name => 'index_taggings_uniquely2'
  end

  def self.down
    remove_index :taggings, :name => 'index_taggings_uniquely2'
    add_index :taggings, [:taggable_id, :taggable_type, :tag_id], :unique => true, :name => 'index_taggings_uniquely'
  end
end
