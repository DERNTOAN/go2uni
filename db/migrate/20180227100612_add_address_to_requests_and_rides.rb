class AddAddressToRequestsAndRides < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :from_address, :string
    add_column :requests, :to_address, :string
    add_column :rides, :from_address, :string
    add_column :rides, :to_address, :string
  end
end
