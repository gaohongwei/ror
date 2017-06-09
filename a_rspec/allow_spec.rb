
find  spec -name *.rb|xargs grep allow|sed -e "s/.*allow/allow/"

allow_any_instance_of(User).to receive(:name).and_return('name')
allow(Settings).to receive(:exchange) { { enable: true } }
allow(Settings).to receive(:exchange)and_return({ enable: true })
allow(controller).to receive(:action_name) { 'show' }
allow(controller).to receive(:controller_name) { 'global_settings' }
allow(user).to receive(:full_name).with('xxx').and_return(true)

controller.stub_chain(:remediation_service, :remove_direct_links).and_return(OpenStruct.new(status: 200))
