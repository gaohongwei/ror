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
