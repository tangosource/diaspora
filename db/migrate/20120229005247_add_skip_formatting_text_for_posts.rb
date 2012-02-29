class AddSkipFormattingTextForPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do|t|
      t.boolean :skip_formatting, :default => false
    end
  end

  def self.down
    change_table :posts do|t|
      t.remove :skip_formatting
    end
  end
end
