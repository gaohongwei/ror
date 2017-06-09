rails g scaffold loan     property_id:integer amount:integer
rails g scaffold property street_name:string
rails g scaffold property_owner property_id::integer  user_id::integer 
class Loan < ActiveRecord::Base
  scope :by_user, lambda { |id|
    joins( :property => {:property_owners=>:user} ).merge(User.by_user(id))
  }
end

Post.joins(:tags).group("tags.name").count
# => {"tag1" => 4, "tag2" => 2, "tag3" => 5}

class OptionUser < ActiveRecord::Base
  #OptionUser.joins(:option)
  belongs_to :option, :class_name=>'TaskOption',:foreign_key=>'option_id'
  OptionUser.joins(:option=>(:task))

  scope :by_task,lambda {|id|
    joins(:option=>(:task)).merge(Task.where(id:id))
  } # id can be a array, [1,2]
end
