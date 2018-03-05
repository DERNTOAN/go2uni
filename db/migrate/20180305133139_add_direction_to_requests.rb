class AddDirectionToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :direction, :string
  end
end
