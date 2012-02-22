class AddSearchStringToDestinations < ActiveRecord::Migration
  def self.up
    add_column :destinations, :search_string, :string
    Destination.reset_column_information
    Destination.all.each do |destination|
      print '.'
      destination.save
    end
  end

  def self.down
    remove_column :destinations, :search_string
  end
end
