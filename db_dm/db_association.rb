======== Sample ========
rails g model group name:string parent_id:integer

======== :class_name ========
apply to has_many/has_one/belongs_to
If the name of the other model cannot be derived from the association name, 
you can use the :class_name option to supply the model name.
class_name: 'Group'

======== :foreign_key ========
The :foreign_key option lets you set the name of the foreign key.
Can be on belongs_to and has_many
class Employee < ActiveRecord::Base
#rails g  model employee name:string mgr_id:integer
  belongs_to :boss, foreign_key: :mgr_id, class_name: 'EmployeeA'
  has_many   :subs, foreign_key: :mgr_id, class_name: 'EmployeeB'
end
For boss
select EmployeeA.* from EmployeeA where EmployeeA.id = employee.mgr_id
For sub
select EmployeeB.* from EmployeeB where EmployeeB.mgr_id = employee.id

======== Child table, belongs_to ========
Can have a belongs_to association
Need a foreign_key
belongs_to :parent, foreign_key: :parent_id, class_name: 'Group'

======== has_many ========
has_many/has_one/belongs_to
Rails assumes that the column used to hold the foreign key on the other model is 
the name of this model with the suffix _id added. 
If not, you need specify class_name

======== :source ========
The :source option specifies the source association name for a 
has_many/has_one :through association. 
:source is used (optionally) to define the associated model name when you're using has_many  through; 
:class_name is used (optionally) in a simple has many relationship. 

======== :primary_key ========
Haven't found use case yet
By convention, Rails assumes that the column used to hold the primary key of the association is id. 
You can override this and explicitly specify the primary key with the :primary_key option.

Self Joins
class Employee < ActiveRecord::Base
#rails g  model employee name:string mgr_id:integer
  belongs_to :boss, foreign_key: :mgr_id, class_name: 'Book'
  has_many   :subs, foreign_key: :mgr_id, class_name: 'Book'
end
class Employee < ActiveRecord::Base
  has_many :subordinates, class_name: "Employee",
                          foreign_key: "manager_id"
 
  belongs_to :manager, class_name: "Employee"
end


http://guides.rubyonrails.org/association_basics.html

---------- :source ----------
class User
  has_many :subscriptions
  has_many :newsletters, :through => :subscriptions
end

class Newsletter
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  # Rename to subscribers
  has_many :subscribers, :through => :subscriptions, :source => :user  
end

# user_id, newsletter_id
class Subscription
  belongs_to :newsletter
  belongs_to :user
end
With this code, you can do something like 
Newsletter.find(id).users to 
get a list of the newsletter's subscribers. 

But if you want to be clearer and be able to type 
Newsletter.find(id).subscribers instead, 
you must change the Newsletter class to this:

You are renaming the users association to subscribers. 
If you don't provide the :source, Rails will look for an association 
called subscriber in the Subscription class. 
You have to tell it to use the user association 
in the Subscription class to make the list of subscribers.
