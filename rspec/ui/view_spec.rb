
allow(Event).to receive(:default_per_page) { 100 }

# check nested dom
  expect(rendered).to have_tag('th', text: 'Date', with: { class: 'width_90px sortable' }) do
    with_tag 'a', 'data-remote' => 'true', href: events_path(search: search.sort_by(:cloud_created_at).to_params)
  end

# data model
  it { is_expected.to have_fields(:include_fix_buttons).of_type(Mongoid::Boolean).with_default_value_of(true) }
  
# view
  render
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  expect(response).to render_template(:new)
  expect(response).to redirect_to(location)  
  expect(response).to have_http_status(:created)
  expect(assigns(:widget)).to be_a_new(Widget)

  expect(rendered).to match(/New Message/)
  expect(rendered).not_to have_tag('h2', text: 'Attached Risks')
  expect(rendered).to have_tag(
    :input, 
    with: 
      {
        type: 'text',
        id: "message_#{field}_str",
        name: "message[#{field}_str]",
        class: 'string optional form-control'
      }
  )
  
  
  #render_views

  it "Locked user can be unlocked by url" do
    @user.lock_access!
=begin
    user.reload.unlock_access!
    https://localhost:3001/d/users/unlock?unlock_token=q1f4KyCjkUUxv__Y4Yqn
    get :unlock, token: @user.reload.unlock_token
    get "users/unlock?#{@user.reload.unlock_token}"
=end
    @controller = controller = Devise::UnlocksController.new
    get :show, unlock_token: @user.reload.unlock_token
    expect(@response.status).to eq(200)
    byebug
    #expect(response).to redirect_to('/d/users/sign_in')
    puts "token=#{@user.reload.unlock_token}"
    login_as_user(@user)
    expect(@response.status).to eq(302)
    expect(@user.reload.failed_attempts).to eq(0)
    expect(@user.reload.unlock_token).to be_nil
  end
