@objs = Kaminari.paginate_array(@objs, total_count: total_count).page(params[:page]).per(15) 
