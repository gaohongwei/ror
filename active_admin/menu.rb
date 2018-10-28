ActiveAdmin.register Post do
  menu false
  menu label: "My Posts"
  menu label: proc{ I18n.t "mypost" }
  menu priority: 1 # so it's on the very left
  menu if: proc{ current_user.can_edit_posts? }
  menu parent: "Blog"
end
