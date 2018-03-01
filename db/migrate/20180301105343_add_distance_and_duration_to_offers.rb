class AddDistanceAndDurationToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :duration_to_car, :integer
    add_column :offers, :distance_to_car, :integer
    add_column :offers, :duration_to_dest, :integer
    add_column :offers, :distance_to_dest, :integer

  end
end
