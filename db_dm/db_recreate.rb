##################### Drop table
ActiveRecord::Migration.drop_table(:menus)
rake db:migrate:redo VERSION=20150221001521
heroku run rake db:migrate:redo VERSION=20150513164818 

# Truncate and reset ID to 1
ActiveRecord::Base.connection.execute("TRUNCATE table_name")
ActiveRecord::Base.connection.execute("TRUNCATE comments;TRUNCATE comments")
ActiveRecord::Base.connection.reset_pk_sequence!('comments') # only pg needs this


# Truncate and reset ID to 1 by rake task
heroku run rake db:truncate 
