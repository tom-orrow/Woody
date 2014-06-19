ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Projects Updates' do
          table_for Project.limit(5).order('updated_at DESC') do
            column('Title')      { |project| link_to(project.name, admin_project_path(project)) }
            column('Updated At') { |project| project.updated_at }
          end
          hr
          b "Total: #{Project.all.count}"
        end
      end
      # column do
      #   panel 'Recent Blog Updates' do
      #     table_for Post.limit(5).order('updated_at DESC') do
      #       column('Title')      { |post| link_to(post.title, admin_post_path(post)) }
      #       column('Updated At') { |post| post.updated_at }
      #     end
      #     hr
      #     b "Total: #{Post.all.count}"
      #   end
      # end
    end
  end
end
