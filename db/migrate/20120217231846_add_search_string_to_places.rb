class AddSearchStringToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :search_string, :string
    Place.reset_column_information

    Place.find_in_batches do |places|
      places.each do |place|
        print '.'
        place.save
      end
    end
  end

  def self.down
    remove_column :places, :search_string 
  end
end
