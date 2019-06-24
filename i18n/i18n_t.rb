### tt
  def i18n_t(key, *args)
    I18n.t(key, :default => key, args)
  end

key = 'active_admin.help_index'
args = {item: 'abc', item1: '123'}
I18n.t(key, args)

alias_method :tt, :i18n_t
tt(key, args)


def go(x, *args)
  puts args.class
  puts args
  puts *args
end

go("a", "b", "c")
