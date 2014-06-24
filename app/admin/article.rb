ActiveAdmin.register Article do
  filter :created_at

  index do
    column :title do |article|
      b link_to article.title, edit_admin_article_path(article)
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.actions
    f.inputs 'Content' do
      f.input :title
      f.input :slug
      f.input :body, as: :ckeditor
      f.input :image, as: :file, hint: f.template.image_tag(f.object.image.url(:thumb))
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit article: [:title, :body, :image, :slug]
    end

    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end
end
