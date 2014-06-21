ActiveAdmin.register Article do
  filter :created_at

  actions :index, :show, :edit, :update, :destroy

  index do
    column :name do |article|
      b link_to article.name, edit_admin_article_path(article)
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.actions
    f.inputs 'Content' do
      f.input :name
      f.input :body, input_html: { class: "tinymce_editor" }
      f.input :image, as: :file, hint: f.template.image_tag(f.object.image.url(:thumb))
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit article: [:name, :body, :image]
    end
  end
end
