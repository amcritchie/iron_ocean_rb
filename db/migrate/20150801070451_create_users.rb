class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :admin, :default => false
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.boolean :email_confirmed, :default => false
      t.boolean :active, :default => true
      t.timestamp :last_active

      t.timestamps
    end
  end
end
