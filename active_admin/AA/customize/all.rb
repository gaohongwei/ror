  action_item do
    link_to "Do smth", dosmth_admin_products_path
  end

  member_action :showimport, :method=>:get do

  end

  member_action :import, :method=>:post do
    
  end

  collection_action :dosmth, :method => :get do
    
  end

  controller do
    ..
    def import
      @product = Product.find(params[:id])

      # access uploaded file - params[:file]

      # do the job


      # redirect
      redirect_to showimport_admin_product_path(@product), :notice=>'Imported'
    end
  end

  index :as => :table do
    column :title
    column :price
    
    actions

  end
