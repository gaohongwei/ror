ActiveAdmin.register Product do
  before_create do |item|
    item.user = current_user
  end
end
