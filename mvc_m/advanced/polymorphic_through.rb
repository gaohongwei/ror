Different models sharing the same join table in Ruby on Rails
https://medium.com/@utkukaynar/polymorphic-has-many-through-associations-in-ruby-on-rails-97778e1cea1a

  Task, Project and Group models
  All have them have multiple members, i.e. Users.

Data Model
  rails g scaffold user  name email
  rails g scaffold group gname
  rails g scaffold project pname
  rails g scaffold membership user_id:integer memberable_type:string memberable_id:integer

  u1 = User.create(name: 'wei01')
  u2 = User.create(name: 'wei02')
  g1 = Group.create(gname: 'group01')
  g2 = Group.create(gname: 'group02')
  p1 = Project.create(pname: 'project01')
##Polymorphic membership solution
  class Membership < ApplicationRecord
    # membership has
    #   user_id, memberable_type, memberable_id
    belongs_to :user
    belongs_to :memberable, polymorphic: true
  end
  class Project < ApplicationRecord
    has_many :memberships, as: :memberable, dependent: :destroy
    # FK: memberable_type: Project, memberable_id: id
    has_many :users, through: :memberships
  end
  class Group < ApplicationRecord
    has_many :memberships, as: :memberable, dependent: :destroy
    # FK: memberable_type: Group, memberable_id: id
    has_many :users, through: :memberships
  end
  class User < ApplicationRecord
      has_many :memberships # memberships has user_id as FK
      has_many :projects, through: :memberships,
        source: :memberable,
        source_type: 'Project'
      has_many :groups, through: :memberships,
        source: :memberable,
        source_type: 'Group'
  end
  
##DRY Polymorphic membership solution
  module Memberable
    extend ActiveSupport::Concern
    included do
      has_many :memberships, as: :memberable, dependent: :destroy
      has_many :users, through: :memberships
      after_create :create_membership
    end

    def create_membership
      Membership.create(memberable_type: self.class.name, memberable_id: self.id, user_id: self.creator_id)
    end
  end

  class Project < ActiveRecord::Base
    include Memberable
  end

  class Group < ActiveRecord::Base
    include Memberable
  end
  
  
##has_many through solution
  class Membership
    belongs_to :user
    belongs_to :memberable, polymorphic: true
  end

  class Project
    has_many :memberships, as: :memberable
    has_many :users, through: :memberships
  end

  class Group
    has_many :memberships, as: :memberable
    has_many :users, through: :memberships
  end

  class User
    #as_many :memberships, as: :memberable, xxxx wrong
    has_many :memberships # fk: user_id
    has_many :projects, through: :memberships,
      source: :memberable,
      source_type: 'Project'
    # etc...
  end
