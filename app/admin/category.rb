ActiveAdmin.register Category do
  actions :index, :show, :edit, :update, :destroy

  index do
    column :name do |category|
      b link_to category.name, edit_admin_category_path(category)
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Content' do
      f.input :name
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit category: [:name]
    end
  end
end
