class CreateCategoriesProjectsJoinTable < ActiveRecord::Migration
  def up
    create_table :categories_projects, id: false do |t|
      t.integer :category_id
      t.integer :project_id
    end
    add_index :categories_projects, [ :category_id, :project_id ], unique: true, name: 'by_category_and_project'

    remove_column :projects, :category_id
  end

  def down
    add_column :projects, :category_id, :integer
  end
end
