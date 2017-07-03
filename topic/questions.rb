https://career.guru99.com/top-34-ruby-on-rail-interview-questions/
46) Mention what is the syntax for Ruby collect Iterator?

The syntax for Ruby collect Iterator collection = collection.collect.

33) Explain what is Polymorphic Association in Ruby on Rails?

Polymorphic Association allows an ActiveRecord object to be connected with Multiple ActiveRecord objects. A perfect example of Polymorphic Association is a social site where users can comment on anywhere whether it is a videos, photos, link, status updates etc. It would be not feasible if you have to create an individual comment like photos_comments, videos_comment and so on.
 

20) Explain what is Cross-Site Request Forgery (CSRF) and how Rails is protected against it?

CSRF is a form of attack where hacker submits a page request on your behalf to a different website, causing damage or revealing your sensitive data. To protect from CSRF attacks, you have to add “protect_from_forgery” to your ApplicationController. This will cause Rails to require a CSRF token to process the request. CSRF token is given as a hidden field in every form created using Rails form builders.


24) Mention what is the difference between the Observers and Callbacks in Ruby on Rails?

Rails Observers: Observers is same as Callback, but it is used when method is not directly associated to object lifecycle. Also, the observer lives longer, and it can be detached or attached at any time. For example, displaying values from a model in the UI and updating model from user input.
Rails Callback: Callbacks are methods, which can be called at certain moments of an object’s life cycle for example it can be called when an object is validated, created, updated, deleted, A call back is short lived. For example, running a thread and giving a call-back that is called when thread terminates


27) Explain what is sweeper in Rails?

Sweepers are responsible for expiring or terminating caches when model object changes.

29) Explain what is the difference between Dynamic and Static Scaffolding?

Dynamic Scaffolding Static Scaffolding
It automatically creates the entire content and user interface at runtime
It enables to generation of new, delete, edit methods for the use in application
It does not need a database to be synchronized
It requires manual entry in the command to create the data with their fields
It does not require any such generation to take place
It requires the database to be migrated
