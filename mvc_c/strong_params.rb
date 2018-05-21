params = ActionController::Parameters.new({
  person: {
    name: "Francesco",
    age:  22,
    role: "admin", 
    names: %w(abc a1 a2),
    hash: {a: 'aa', b: 'bb'}
  }
})

p1 = params.require(:person).permit(:name, :age, :role)
p2 = params.require(:person).permit(names: [])
p3 = params.require(:person).permit(hash: {})
p4 = params.require(:person).permit(
  :name, 
  :age, 
  :role, 
  names: [], 
  hash: {}
)


params.permit(
  :name, 
  { emails: [] },
  friends: [ :name,
              { family: [ :name ], 
                hobbies: [] 
              }
            ]
)
This declaration whitelists the name, emails, and friends attributes. 
emails will be an array of permitted scalar values, 
friends will be an array of resources with specific attributes: 
  a name attribute (any permitted scalar values allowed), 
  a hobbies attribute as an array of permitted scalar values, 
  a family attribute which is restricted to having a  name (any permitted scalar values allowed here, too).
