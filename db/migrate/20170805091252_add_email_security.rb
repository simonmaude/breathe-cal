class AddEmailSecurity < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.string :email_key
      t.string :language
      t.string :email_is_confirmed
    end
  end
end
