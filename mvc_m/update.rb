update_all(updates, conditions = nil, options = {})
  No callbacks or validations.
  This method constructs a single SQL UPDATE statement and 
  sends it straight to the database. 

  It does not instantiate the involved models and 
  

update_columns
  No callbacks or validations.
  updated_at/updated_on are not updated.  
  Updates the attributes directly in the database issuing an UPDATE SQL statement and sets them in the receiver:

  This is the fastest way to update attributes 
  because it goes straight to the database, 
  but take into account that in consequence the regular update procedures are totally bypassed. 

update
  update(id, attributes)
  Updates an object or multiple objects
  and saves it to the database, if validations pass. 

  The resulting object is returned whether the object was saved successfully to the database or not.

  # Updating one record:
  Person.update(15, :user_name => 'Samuel', :group => 'expert')

  # Updating multiple records:

  people = { 
    1 => { "first_name" => "David" }, 
    2 => { "first_name" => "Jeremy" } 
  }
  Person.update(people.keys, people.values)
