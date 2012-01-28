class AddProfilePublic < ActiveRecord::Migration
  def self.up
    add_column :profiles, :public, :boolean, :default=>true
  end

  def self.down
    remove_column :profiles, :public
  end
end
