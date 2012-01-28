class CreateDestinations < ActiveRecord::Migration
  def self.up
    create_table :destinations do |t|
      t.text :summary
      t.string :title
      t.string :permalink
      t.string :photo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :destinations
  end
end
