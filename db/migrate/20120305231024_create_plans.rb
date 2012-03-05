class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :name
      t.float :amount
      t.string :interval
      t.string :currency

      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
