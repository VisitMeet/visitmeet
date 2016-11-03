class AddStripeCardTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :card_token, :string
  end
end
