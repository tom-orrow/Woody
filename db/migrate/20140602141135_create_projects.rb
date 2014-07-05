class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :desc, null: false
      t.integer :position, null: false, default: 0
      t.belongs_to :category
      t.belongs_to :article, default: nil
      t.boolean :featured, default: false
      t.timestamps
    end
  end
end
