======== Explaination and sample ========
:source define the associated model name for has_many through association
:foreign_key option lets you set the name of the foreign key.
:class_name, used by belongs_to, has_many
  
1. has_many through sample,  source/foreign_key
  rgu project    name:string
  rgu data_file  name:string 
  rgu project_file  project_id:integer file_id:integer

  class ProjectFile
    # belongs_to specify a foreign key
    # foreign key name convention, xxx => xxx_id
    belongs_to :user    # => a foreign key, user_id
    belongs_to :project # => a foreign key, project_id
    belongs_to :data_file, foreign_key: :file_id
    # Use random name
    belongs_to :fff, foreign_key: :file_id, class_name: 'DataFile'   
    # so ProjectFile should include
    # project_id: integer, file_id: integer, user_id: integer   
  end

  class Project
    belongs_to :user
    #  has_many need 
    #    class_name: 'ProjectFile'
    #    foreign_key: :project_id
    #  mean ProjectFile have a project_id field
    has_many :project_files
    has_many :pfiles, class_name: 'ProjectFile', foreign_key: :project_id 
    # has_many through dont need to specify foreign key
    #   need
    #     source: :data_file
    #   dont need to specify foreign key 
    #     because foreign key has been specified at through association
    has_many :data_files, through: :project_files    
    has_many :dfiles,     through: :project_files, source: :data_file  
    has_many :files,      through: :project_files, source: :data_file 
  end

  class DataFile
    has_many :project_files, foreign_key: :file_id
    has_many :projects, through: :project_files
  end

2. has_many through sample,  source
  has_many :owned_groups, class_name: 'Group'
  has_many :joined_groups, -> { where(user_groups: { status: 3 }) },   through: :user_groups, source: :group
  has_many :applied_groups, -> { where(user_groups: { status: 1 }) },  through: :user_groups, source: :group
  has_many :accepted_groups, -> { where(user_groups: { status: 2 }) }, through: :user_groups, source: :group
  has_many :approved_groups, -> { where(user_groups: { status: 2 }) }, through: :user_groups, source: :group
3. has_many through sample
  rails g scaffold disease name:string 
  rails g scaffold symptom name:string
  rails g scaffold disease_symptom disease_id:integer symptom_id:integer --skip-controller
  
  class Symptom < ActiveRecord::Base
    has_many :disease_symptoms
    has_many :diseases, :through => :disease_symptoms
  end

  class Disease < ActiveRecord::Base
    has_many :disease_symptoms
    has_many :symptoms, :through => :disease_symptoms
  end

  class DiseaseSymptom < ActiveRecord::Base
    belongs_to :disease
    belongs_to :symptom
  end

<%= semantic_form_for @disease do |f| %>
  <%= f.inputs do %>
    <%= f.input :name %>
    <%= f.input :symptoms, :as => :check_boxes, :required => false %>
<%= f.actions %>
  <% end %>
<% end %>
