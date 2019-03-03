#############################################################
# Railscasts PRO #154 Polymorphic Association
https://www.youtube.com/watch?v=WOFAcbxdWjY

A model can belong to multiple models on a single association. 
Add these two for the ploymorphic model
commantable_id:integer 
commentable_type:string

rails g model comment subject:string content:text commantable_id:integer commentable_type:string
rails g model event   name:string description:text
rails g model book    ttile:string description:text

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
end
class Book < ActiveRecord::Base
  has_many :comments, as: :commentable
end
class Event < ActiveRecord::Base
  has_many :comments, as: :commentable
end


@article.comments.
@event.comments.
@comment.commentable ### Shared name

# DB migration
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :content
      t.integer :commentable_id
      t.string  :commentable_type
      t.timestamps null: false
    end
 
    add_index :comments, [:commentable_id,:commentable_type]
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :commentable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end

Controller:
before_filter :load_commentable
def load_commentable
  res,id=request.path.split('/')[1,2] # /photos/1
  @commentable=res.singularize.classify.constantize.find(id)
  # Article.find(1)
end

Nested resource

Comment index view :
link_to "New Comment",[:new, @commentable,:comment]
# /photos/1/comments/new
Comment Show Action:
redirect_to [@commentable, comments], notice:"created"

Form:
form_for [@commentable, @comment]

#############################################################
http://guides.rubyonrails.org/association_basics.html
A picture model can belongs to either an employee model or a product model
class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
 
class Employee < ActiveRecord::Base
  has_many :pictures, as: :imageable
end
 
class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
end

a polymorphic belongs_to declaration sets up an interface for other models. 
@employee.pictures.
@product.pictures.
@picture.imageable

To make this work, you need to declare both a foreign key column and a type column in the polymorphic model.

class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name
      t.integer :imageable_id
      t.string  :imageable_type
      t.timestamps null: false
    end
 
    add_index :pictures, :imageable_id
  end
end

class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.belongs_to :imageable, polymorphic: true, index: true #option 1
      t.references :imageable, polymorphic: true, index: true #option 2       
      t.timestamps null: false
    end
  end
end
