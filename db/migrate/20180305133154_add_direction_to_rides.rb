class AddDirectionToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :direction, :string
  end
end
