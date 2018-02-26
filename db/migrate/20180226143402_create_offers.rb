class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.references :ride, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
  end
end
