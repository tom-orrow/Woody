ActiveAdmin.register Project do
  filter :category
  filter :created_at

  index do
    column :name do |project|
      b link_to project.name, edit_admin_project_path(project)
    end
    column "Category" do |project|
      p project.category.name
    end
    column :featured
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.actions
    f.inputs 'Content' do
      f.input :name
      f.input :short_desc
      f.input :desc
      f.input :featured
      f.input :category, include_blank: false
      f.has_many :project_images do |ff|
        ff.input :image, as: :file, hint: ff.template.image_tag(ff.object.image.url(:thumb))
        ff.input :_destroy, as: :boolean, label: "Удалить"
      end
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit project: [:name, :short_desc, :desc, :featured, :category_id, project_images_attributes: [:_destroy, :id, :project_id, :image]]
    end

    def scoped_collection
      Project.includes(:category)
    end
  end
end
