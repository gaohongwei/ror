app/admin/post.rb

  index do
    column :title
    column :description
    column :user
    id_column
    actions
  end

  controller do
    def scoped_collection
      super.includes :user
    end
  end
