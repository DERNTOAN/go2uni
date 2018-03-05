class AddUniToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :uni, :string
  end
end
