System level
  list="postgresql postgresql-contrib libpq-dev"
  apt-get -y install $list
  update-rc.d postgresql enable # for reboot
  service postgresql start # start

Database user/role
  sudo su postgres -c  "createuser root --pwprompt"  
  sudo su postgres -c  "create role web with createdb login password 'password1'"  

  sudo -u postgres dropdb   $dbname
  sudo -u postgres createdb $dbname
  
sql
  su - postgres
  psql
  ;
  \q

config database.yml 
  development:
    adapter: postgresql
    encoding: unicode
    database: myapp_development
    pool: 5
    username: myapp
    password: password1

  test:
    adapter: postgresql
    encoding: unicode
    database: myapp_test
    pool: 5
    username: myapp
    password: password1
  
  
rake db:setup
rake db:migrate
