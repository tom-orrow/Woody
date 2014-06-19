class CreateProjectImages < ActiveRecord::Migration
  def change
    create_table :project_images do |t|
      t.string :image
      t.belongs_to :project
    end
  end
end
