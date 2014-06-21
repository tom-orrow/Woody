class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.text :body, null: false
      t.string :image
      t.timestamps
    end
  end
end
