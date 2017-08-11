class AddFavoritesToClients < ActiveRecord::Migration
  def change
    add_column :clients, :favorites, :text
  end
end
