Load yaml file
  require "yaml"

  test_obj = ["dogs", "cats", "badgers"]
  yaml_obj = YAML::dump( test_obj )
  ruby_obj = YAML::load( yaml_obj )         
  ruby_obj == test_obj # true

  ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
  $aws_db_credentials = YAML.load_file('config/database.yml')[Sinatra::Base.environment.to_s].symbolize_keys!
# Save into yaml file
  File.open('/tmp/test.yml', 'w') {|f| f.write ActiveRecord::Base.configurations.to_yaml } #Store

  File.open(SETTINGS_FILE, "w") do |file|
    file.write settings.to_yaml
  end

Setting.where("var like '%:zh-CN'").update_all(lang_id:1)
Setting.where("var like '%:en'").update_all(lang_id:2)
Setting.update_all(section_id:1)

File.write('a.txt',Setting.all.to_yaml)

File.write('a.txt',Setting.to_json.to_yaml)
