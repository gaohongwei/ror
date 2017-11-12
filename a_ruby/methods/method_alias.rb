self.singleton_class.send(:alias_method, :new_name, :original_name)

alias_method, :new_name, :original_name
