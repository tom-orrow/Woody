ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Projects Updates' do
          table_for Project.limit(5).order('updated_at DESC') do
            column('Name')      { |project| link_to(project.name, admin_project_path(project)) }
            column('Updated At') { |project| project.updated_at }
          end
          hr
          b "Total: #{Project.all.count}"
        end
      end
      column do
        panel 'Recent Articles Updates' do
          table_for Article.limit(5).order('updated_at DESC') do
            column('Title')      { |article| link_to(article.title, admin_article_path(article)) }
            column('Updated At') { |article| article.updated_at }
          end
          hr
          b "Total: #{Article.all.count}"
        end
      end
    end
  end
end
