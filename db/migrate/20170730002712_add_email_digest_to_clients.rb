class AddEmailDigestToClients < ActiveRecord::Migration
  def change
    add_column :clients, :email_digest, :boolean
  end
end
