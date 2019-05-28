settings_file = File.join(Rails.root, "config", "settings.yml")
SETTINGS = YAML.safe_load(ERB.new(IO.read(settings_file)).result)
