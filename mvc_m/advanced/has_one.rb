Add has_one on has_many

  has_many :contact_addressables, as: :addressable
  has_many :contact0s, -> { where(purpose: 0) }, as: :addressable, class_name: 'ContactAddressable'
  has_many :contact5s, -> { where(purpose: 5) }, as: :addressable, class_name: 'ContactAddressable'
  has_one :contact0,   -> { where(purpose: 0).order(updated_at: :desc) }, as: :addressable, class_name: 'ContactAddressable'
  has_one :contact5,   -> { where(purpose: 5).order(updated_at: :desc) }, as: :addressable, class_name: 'ContactAddressable'

  has_many :contact1s, source_type: 'XXX', foreign_key: 'addressable_id', class_name: 'ContactAddressable'
  has_many :contact2s, source_type: 'XXX', as: :addressable, class_name: 'ContactAddressable'

Other Samples
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
