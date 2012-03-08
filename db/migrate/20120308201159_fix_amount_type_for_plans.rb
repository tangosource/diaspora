class FixAmountTypeForPlans < ActiveRecord::Migration
  def self.up
    change_table :plans do |t|
      t.change :amount, :integer
    end
  end

  def self.down
    change_table :plans do |t|
      t.change :amount, :float
    end
  end
end
