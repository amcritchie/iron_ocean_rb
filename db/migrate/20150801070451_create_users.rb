class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :password_reset_token

      t.boolean :email_confirmed, :default => false
      t.boolean :active, :default => true

      t.timestamp :last_active
      t.timestamp :password_reset_sent

      t.timestamps
    end
  end
end
