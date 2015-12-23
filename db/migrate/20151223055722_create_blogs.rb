class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :slug
      t.integer :admin_id

      t.timestamps
    end
  end
end
