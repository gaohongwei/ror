https://hashrocket.com/blog/posts/debugging-action-callbacks-aka-filters-in-rails

_process_action_callbacks
  callback actions are stored here

before_actions
  _process_action_callbacks.map { |c| c.filter if c.kind == :before }
  _process_action_callbacks.map { |c| {c.filter => c.options} if c.kind == :before }

after_actions
  _process_action_callbacks.map { |c| c.filter if c.kind == :after }


show-source authenticate_user!
edit authenticate_user!
