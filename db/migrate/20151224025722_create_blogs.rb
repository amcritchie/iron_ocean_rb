class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :slug

      t.boolean :active

      t.timestamps
    end
  end
end
