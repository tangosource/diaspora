class AddHideBirthdayToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :hide_birthday, :boolean, :default => false
  end

  def self.down
    remove_column :profiles, :hide_birthday
  end
end
