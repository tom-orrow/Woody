class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :image
      t.string :slug
      t.timestamps
    end

    add_index :articles, :slug, unique: true
  end
end
