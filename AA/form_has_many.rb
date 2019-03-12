
  address_f.input :address_addressables,
          as: :check_boxes,
          collection: ContactAddressable.purposes,
          label: 'Purpose'
          
  address_f.has_many :address_addressables do |purpose_f|
    purpose_f.input :purpose, :label => 'Purpose', :as => :select, :collection => ContactAddressable.purposes
  end
