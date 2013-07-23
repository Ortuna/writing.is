# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Writing::Application.load_tasks

Rake::TaskManager.class_eval do
  def delete_task(task_name)
    @tasks.delete(task_name.to_s)
  end
  Rake.application.delete_task("test")
  Rake.application.delete_task("test:all")
  Rake.application.delete_task("test:all:db")
  Rake.application.delete_task("test:recent")
  Rake.application.delete_task("test:uncommitted")
end
task :default => :spec
