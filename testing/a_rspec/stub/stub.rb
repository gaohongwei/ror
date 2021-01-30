## stub_chain
  Service.stub_chain(:list).and_return([])
  Service.stub_chain(:list).and_return([])

  Service.stub_chain(:new, :raw_token).and_return('token')
  Service.stub_chain(:service).with('authz').and_return('10.0.0.0')
  Service.stub_chain(:service_port).with('authz').and_return('8080')
      
## stub_const, Constant
  stub_const("Klass::MAX_PIXEL", 10)
  stub_const('ENV', {'RACK_ENV' => 'production'})
  stub_const("::Session", double(:session, key: 'key'))  
  ENV.stub(:[]).with("RACK_ENV").and_return("production")

## Stub global hash variables
  allow($servers).to receive(:[]).with(:hz_version).and_return('3.1')
  $servers.stub(:[]).with(:hz_version).and_return('3.1')
