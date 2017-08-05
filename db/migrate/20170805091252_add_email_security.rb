class AddEmailSecurity < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.string :email_key
      t.string :language
      t.boolean :email_is_confirmed
      t.datetime :key_creation_time
    end
  end
end
