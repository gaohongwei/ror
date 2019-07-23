Get Database Version
  rake db:version
  ActiveRecord::Migrator.current_version
  ActiveRecord::Migrator.get_all_versions

Run 
  rake db:migrate:redo VERSION=20190722123456
