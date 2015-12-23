class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
