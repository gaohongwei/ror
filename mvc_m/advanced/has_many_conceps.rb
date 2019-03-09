======== Concepts ========
:source define the associated model name for has_many through association

:foreign_key option lets you set the name of the foreign key
  used in the other model
Can be on belongs_to and has_many (no through)

:class_name define model name in a simple foreign key relationship.
  used by belongs_to/has_many/has_one(no through)

  If the name of the other model cannot be derived from the association name,
  you can use the :class_name option to supply the model name.
======== Sample ========
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
