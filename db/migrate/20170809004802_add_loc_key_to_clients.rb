class AddLocKeyToClients < ActiveRecord::Migration
  def change
    add_column :clients, :loc_key, :int
  end
end
