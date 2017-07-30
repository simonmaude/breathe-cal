class AddEmailAlertsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :email_alerts, :boolean
  end
end
