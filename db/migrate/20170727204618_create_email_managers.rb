class CreateEmailManagers < ActiveRecord::Migration
  def change
    create_table :email_managers do |t|
      t.string :alert
      t.string :previous_alert

      t.timestamps null: false
    end
  end
end
