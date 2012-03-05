class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :company_name
      t.string :address
      t.integer :zip
      t.string :country
      t.string :billing_address
      t.string :billing_zip
      t.string :billing_country
      t.string :stripe_customer_token

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
