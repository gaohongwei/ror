# List all models from rails console
ActiveRecord::Base.subclasses.map(&:name)

#select some columns
  Widget.select("name,id").all

#define scope
  scope :by_controller, lambda {|controller|
    where(:controller=>controller)
  }
  scope :bycontroller, ->(controller) {
    where(:controller=>controller)
  }
  
User.where('email like ?','%gmail.com%').to_sql

Virtual attribute
  attr_accessor :layout_type,:column_per_row
  
Access control
attr_accessible(*args) public
Specifies a white list of model attributes that can be set via mass-assignment.

attr_accessible(*args) public
Specifies a white list of model attributes that can be set via mass-assignment.

Like attr_protected, a role for the attributes is optional, if no role is provided then :default is used. 
A role can be defined by using the :as option.

This is the opposite of the attr_protected macro: 
Mass-assignment will only set attributes in this list, to assign to the rest of attributes 
you can use direct writer methods. This is meant to protect sensitive attributes from 
being overwritten by malicious users tampering with URLs or forms. 
If you’d rather start from an all-open default and restrict attributes as needed, have a look at attr_protected.
