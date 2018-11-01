copy a file from a gem to rails application
namespace :config do
  # desc "Copy the config"
  task :copy do
    source = File.join(Gem.loaded_specs["myGem"].full_gem_path, "config", "config.yml")
    target = File.join(Rails.root, "config", "myGemConfig.yml")
    FileUtils.cp_r source, target
  end
end
