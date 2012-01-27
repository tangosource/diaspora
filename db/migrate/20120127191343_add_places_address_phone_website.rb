class AddPlacesAddressPhoneWebsite < ActiveRecord::Migration
  def self.up
    add_column :descriptions, :address, :text
    add_column :descriptions, :phone, :string
    add_column :descriptions, :website, :string

  end

  def self.down
    remove_column :descriptions, :address
    remove_column :descriptions, :phone
    remove_column :descriptions, :website
  end
end
