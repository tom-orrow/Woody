class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.integer :article_id, default: nil
      t.belongs_to :category
      t.boolean :featured, default: false
      t.timestamps
    end
  end
end
