class AddLocationToClients < ActiveRecord::Migration
  def change
    add_column :clients, :location, :string
  end
end
