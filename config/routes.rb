Woody::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'main#index'
  get 'articles/:id' => 'main#show', as: 'article'
  post 'articles/more' => 'main#load_more_articles', as: 'load_more_articles'
end
