class AddUserAlias < ActiveRecord::Migration
  def self.up
    add_column :profiles, :hide_full_name, :boolean
    add_column :profiles, :hidden_first_name, :string
    add_column :profiles, :hidden_last_name, :string
  end

  def self.down
    remove_column :profiles, :hide_full_name
    remove_column :profiles, :hidden_first_name
    remove_column :profiles, :hidden_last_name
  end
end
