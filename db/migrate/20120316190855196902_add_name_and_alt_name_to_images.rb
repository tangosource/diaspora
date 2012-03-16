class AddNameAndAltNameToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :name, :string
    add_column :images, :alt_name, :string
  end

  def self.down
    remove_column :images, :name
    remove_column :images, :alt_name
	end
end
