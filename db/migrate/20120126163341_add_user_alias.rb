class AddUserAlias < ActiveRecord::Migration
  def self.up
    add_column :profiles, :alias, :string
  end

  def self.down
    remove_column :profiles, :alias
  end
end
