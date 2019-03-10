Add has_one on has_many

Approach 1 - Add a new association

  Add an has_one association with a where lambda. This allows you to work within your current schema.

  class Account 
    has_many :users
    has_one  :primary_user, -> { where(is_primary: true) }, :class_name=> "User"
  end

  account.users 
  account.primary_user #returns the primary user associated with the account
  
  # creates a user with is_primary set to true
  account.build_primary_user(name: 'foo bar', email: 'bar@foo.com')


Approach 2 - Add an association method

  class Account 
    has_many :users do
      def primary
        where(:is_primary => true).first
      end
    end
  end

  account.users.primary # returns the primary account
