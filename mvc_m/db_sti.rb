### Need a type:string column to specify the class type
rails g model user name:string email:string type:string
### Or add later
rails g model user name:string email:string
rails g migration AddTypeToUser type:string 

class Guest < User
end

User.create(name:'wei1', email:'wei1@gmail.com')
Guest.create(name:'wei2', email:'wei2@gmail.com')

Guest.create(name:'wei3', email:'wei3@gmail.com')


### The problems
Use polymorphic if there are 3 or more columns
