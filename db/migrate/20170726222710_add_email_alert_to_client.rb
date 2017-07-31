class AddEmailAlertToClient < ActiveRecord::Migration
  def change
    add_column :clients, :email_alert, :boolean
  end
end
