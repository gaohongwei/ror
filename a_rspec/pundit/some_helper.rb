  ACTIONS_ON_EXISTING = %i(index? show? edit? update? destroy?)

  private def allow_actions(apolicy, actions)
    actions.each do |action|
      expect(apolicy.send(action)).to eq(true)
    end
  end

  private def forbid_actions(apolicy, actions)
    actions.each do |action|
      expect(apolicy.send(action)).to eq(false)
    end
  end
