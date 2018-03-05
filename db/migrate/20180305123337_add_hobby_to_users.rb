class AddHobbyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hobby, :string
  end
end
