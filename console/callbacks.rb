_process_action_callbacks
  callback actions are stored here

before_actions
  _process_action_callbacks.map { |c| c.filter if c.kind == :before }
  _process_action_callbacks.map { |c| {c.filter => c.options} if c.kind == :before }

after_actions
  _process_action_callbacks.map { |c| c.filter if c.kind == :after }
