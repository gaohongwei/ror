## Data Model
      SyslogReceiver.stub_chain(:list).and_return([])
      SyslogApp.stub_chain(:list).and_return([])
      
      ServiceAuthz.stub_chain(:new, :raw_token).and_return('token')
      ServiceDiscovery.stub_chain(:service).with('authz').and_return('10.0.0.0')
      ServiceDiscovery.stub_chain(:service_port).with('authz').and_return('8080')
