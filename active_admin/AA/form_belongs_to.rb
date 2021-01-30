class User < ActiveRecord::Base
  has_many :registrations
end

class Registration < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
end


ActiveAdmin.register Registration do
  #Do not forget the :id for user_attributes
  permit_params :registration_date, :image, user_attributes: [:id, :name, :email]

  form do |f|
    f.inputs "Registration fields" do
      f.input :registration_date
      f.input :image
    end

    f.inputs "User fields", for: [:user, registration.user || User.new] do |u|
      u.input :name
      u.input :name
    end
    f.actions
  end

end
