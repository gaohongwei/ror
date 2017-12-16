0. check status
  rake db:migrate:status
  
1. change default 'db/migrate' path
  config.paths['db/migrate'] = ['db/my_migrate']
  
2. Redefine task
task_exists = Rake.application.tasks.any? { |t| t.name == 'db:create' }
Rake::Task['db:create'].clear if task_exists

# then re-define
namespace 'db' do
  task 'create' do
    # ...
  end
end

If you want to add tasks to an existing rake task, use enhance.
Rake::Task['db:create'].enhance do
  Rake::Task['db:after_create'].invoke
end
