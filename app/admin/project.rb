ActiveAdmin.register Project do
  config.sort_order = 'position_asc'
  filter :category

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
      f.input :desc
      f.input :featured
      f.input :article
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
      params.permit project: [:name, :desc, :featured, :article_id, :category_id, project_images_attributes: [:_destroy, :id, :project_id, :image]]
    end

    def scoped_collection
      Project.includes(:category)
    end
  end

  # JS Sort
  collection_action :sort, method: :post do
    params[:project].each_with_index do |id, index|
      Project.update_all(['position=?', index+1], ['id=?', id])
    end
    render nothing: true
  end
end
