### Redirect calls
  allow(Search::AddToIndexJob).to receive(:perform_later) do |*arg|
    Search::AddToIndexJob.perform_now(*arg)
  end

find  spec -name *.rb|xargs grep allow|sed -e "s/.*allow/allow/"

allow_any_instance_of(User).to receive(:name).and_return('name')
allow(Settings).to receive(:exchange) { { enable: true } }
allow(Settings).to receive(:exchange)and_return({ enable: true })

##### controller 
  allow(controller).to receive(:action_name) { 'show' }
  allow(controller).to receive(:controller_name) { 'global_settings' }
##### view 
  allow(view).to receive(:helper_method)

allow(user).to receive(:full_name).with('xxx').and_return(true)

controller.stub_chain(:remediation_service, :remove_direct_links).and_return(OpenStruct.new(status: 200))
