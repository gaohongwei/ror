From Rails3 to Rails4
##### undefined method `sweep' #####
Production NoMethodError: undefined method `sweep' for {"discard"=>[], "flashes"=>{"just_switched"=>true}}:Hash
Error Message: NoMethodError: undefined method `sweep' for {"discard"=>[], "flashes"=>{"just_switched"=>true}}:Hash
class Hash
  def now
    Rails.logger.warn "Stubbing now during upgrade"
    {}
  end

  def keep
    # stub keep for upgrade purposes
    Rails.logger.warn "Stubbing keep during upgrade"
  end

  def sweep
    # stub sweep for upgrade purposes
    Rails.logger.warn "Stubbing sweep during upgrade"
  end
end


