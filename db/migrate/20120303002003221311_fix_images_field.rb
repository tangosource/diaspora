class FixImagesField < ActiveRecord::Migration
  def self.up
    rename_column :images, :url, :file
  end

  def self.down
    rename_column :images, :file, :url
	end
end
