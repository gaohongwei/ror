class User < ActiveRecord::Base
  has_many :audit_assignments, -> {where(item_type: 'User')}, foreign_key: :item_id
  has_many :audits, through: :audit_assignments
  has_many :roles
  has_many :groups, through: :roles
end

