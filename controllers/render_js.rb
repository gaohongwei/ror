def show
  @user = User.find(params[:id])
  respond_to do |format|
    format.js { render 'hello.js.erb' }
  end
end
