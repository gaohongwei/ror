### tt
  def i18n_t(key, *args)
    I18n.t(key, :default => key, args)
  end
  alias_method :tt, :i18n_t

key = 'active_admin.help_index'
args = {item: 'abc', item1: '123'}
I18n.t(key, args)
tt(key, args)
