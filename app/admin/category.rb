ActiveAdmin.register Category do
  config.sort_order = 'position_asc'

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

  # JS Sort
  collection_action :sort, method: :post do
    params[:category].each_with_index do |id, index|
      Category.update_all(['position=?', index+1], ['id=?', id])
    end
    render nothing: true
  end
end
