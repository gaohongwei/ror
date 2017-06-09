
Person = Struct.new(:name, :age)
person = Person.new("Jim", 32)

expect(person).to have_attributes(:name => "Jim", :age => 32)
expect(person).to have_attributes(:name => a_string_starting_with("J"), :age => (a_value > 30) )

expect(obj).to respond_to(:foo) # pass if obj.respond_to?(:foo)

expect(obj.vertices).to match_array(array_without_order)

RSpec.describe Template, type: :model do
  it { is_expected.to have_fields(:name, :cs_user, :body, :subject, :with_logo).of_type(String) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:subject) }
  it { is_expected.to have_fields(:with_logo).of_type(Mongoid::Boolean).with_default_value_of(false) }
  it { is_expected.to have_field(:name).of_type(String).with_default_value_of('abc') }
