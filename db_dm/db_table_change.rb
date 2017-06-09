##### Update table definition


### Add columns
rails g migration AddSsnToUser ssn:integer cell:string
rails g migration AddAbcToUser ssn1:integer cell1:string

rails g migration AddCommentableIdToComment      commentable_id:integer
rails g migration AddTypeToUser type:string

### Remove columns
rails g migration RemoveCommantableIdFromComment commantable_id:integer
