class AddCarBrandAndCarColorToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :car_brand, :string
    add_column :rides, :car_color, :string
  end
end
