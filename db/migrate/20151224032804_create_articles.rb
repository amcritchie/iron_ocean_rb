class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :body

      t.integer :blog_id
      t.integer :author_id

      t.boolean :active

      t.timestamps
    end
  end
end
