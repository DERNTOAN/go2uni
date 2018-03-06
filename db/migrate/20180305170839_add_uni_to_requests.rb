class AddUniToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :uni, :string
  end
end
