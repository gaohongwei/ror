
Setting.where("var like '%:zh-CN'").update_all(lang_id:1)
Setting.where("var like '%:en'").update_all(lang_id:2)
Setting.update_all(section_id:1)

File.write('a.txt',Setting.all.to_yaml)

File.write('a.txt',Setting.to_json.to_yaml)

File.open(SETTINGS_FILE, "w") do |file|
  file.write settings.to_yaml
end
