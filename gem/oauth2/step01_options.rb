=> {  
  "setup"=>false,
 "skip_info"=>false,
 "client_id"=>"client_id",
 "client_secret"=>"client_secret",
 "client_options"=>
    { 
      "site" => "abc.com",
      "authorize_url"=>"https://secure.sharefile.com/oauth/authorize",
      "token_url"=>"https://secure.sharefile.com/oauth/token"
     },
 "authorize_params"=>{},
 "authorize_options"=>[:scope],
 "token_params"=>{},
 "token_options"=>[],
 "auth_token_params"=>{},
 "provider_ignores_state"=>false,
 "name"=>"citrix"
}

=> {
 "setup"=>false,
 "skip_info"=>false,
 "client_id"=>"65159057968.65161186374",
 "client_secret"=>"dfbbd5c6947b3cd0c2c209ca278bd885",
 "client_options"=>{
   "site"=>"https://slack.com", 
   "token_url"=>"/api/oauth.access"
  },
 "authorize_params"=>{"state"=>"pan--e9496887ff09da1910800ca51117d647fd7edf8a70966973"},
 "authorize_options"=>[:scope, :team],
 "token_params"=>{},
 "token_options"=>[],
 "auth_token_params"=>{"mode"=>:query, "param_name"=>"token"},
 "provider_ignores_state"=>false,
 "name"=>"slack",
 "scope"=>"discovery:read discovery:write"
}

Provide option data for auth, and token
0. All options
      option :client_id, nil # default_options[client_id] = nil
      option :client_secret, nil
      option :client_options, {}
      option :authorize_params, {}
      option :authorize_options, [:scope]
      option :token_params, {}
      option :token_options, []
      option :auth_token_params, {}
      option :provider_ignores_state, false
1. client_id,client_secret, scope
Static id/secret usually can be defined in
initialize/omniauth.rb

2. site, authorize_url, token_url
      option :client_options, {
        authorize_url: "https://secure.sharefile.com/oauth/authorize",
        token_url: "https://secure.sharefile.com/oauth/token"
      }
      option :client_options, {
        :site          => 'https://login.salesforce.com',
        :authorize_url => '/services/oauth2/authorize',
        :token_url     => '/services/oauth2/token'
      }#salesforce

3. authorize_params
      option :authorize_options, [:scope, :team] #slack 
      option :authorize_options, [
        :scope,
        :display,
        :immediate,
        :state,
        :prompt
      ] #salesforce
      option :authorize_params, { key: 'key' }      
      option :authorize_params, {
        resource: 'https://graph.windows.net/'
      } #Office365         
4. token params
      option :token_params, {}
      option :token_options, []
      option :auth_token_params, {}
      option :auth_token_params, {
        mode: :query,
        param_name: 'token'
      }

5 options_for
#There are two calls
options_for('authorize')
options_for('token')
# Sample definitions
option :authorize_options, [:scope, :team] #slack
# options_for("authorize")
# authorize_options = [:scope, :team]
# read elements from authorize_options
# select the elements if options[:scope] or  options[:team]
  
6. Methods
    def option(name, value = nil)
      default_options[name] = value
    end
    def default_options
      return @default_options if instance_variable_defined?(:@default_options) && @default_options
      existing = superclass.respond_to?(:default_options) ? superclass.default_options : {}
      @default_options = OmniAuth::Strategy::Options.new(existing)
    end

    @options = self.class.default_options.dup

    def options_for(option)# OAuth2
      hash = {}
      options.send(:"#{option}_options").select { |key| options[key] }.each do |key|
        hash[key.to_sym] = options[key]
      end
      hash
    end

7 Dynamical params ???
