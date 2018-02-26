class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.references :user, foreign_key: true
      t.integer :seats
      t.datetime :departure_time
      t.float :from_lng
      t.float :from_lat
      t.float :to_lng
      t.float :to_lat

      t.timestamps
    end
  end
end
