class AddDistanceAndDurationToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :duration, :integer
    add_column :rides, :distance, :integer
  end
end
