class AddStripeIdToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :stripe_id, :string
  end

  def self.down
    remove_column :plans, :stripe_id
  end
end
