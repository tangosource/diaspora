class AddDefaultImageToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :is_default_image, :boolean
  end

  def self.down
    remove_column :images, :is_default_image
	end
end
