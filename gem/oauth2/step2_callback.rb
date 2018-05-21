  ############  callback_url,Dont change  ############  
  def callback_url
    full_host + script_name + callback_path
  end
  ############  callback_phase, Dont change  ############    
  def callback_phase # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
    error = request.params["error_reason"] || request.params["error"]
    if error
      fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
    elsif !options.provider_ignores_state && (request.params["state"].to_s.empty? || request.params["state"] != session.delete("omniauth.state"))
      fail!(:csrf_detected, CallbackError.new(:csrf_detected, "CSRF detected"))
    else
      self.access_token = build_access_token
      self.access_token = access_token.refresh! if access_token.expired?
      super
    end
  rescue ::OAuth2::Error, CallbackError => e
    fail!(:invalid_credentials, e)
  rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
    fail!(:timeout, e)
  rescue ::SocketError => e
    fail!(:failed_to_connect, e)
  end
  ############  build_access_token,Dont change  ############    
  def build_access_token
    verifier = request.params["code"]
    client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
  end
  ############  build_access_token,may change  ############ 
  def token_params
    options.token_params.merge(options_for("token"))
  end
  
  Redefined as or provide token_option
  def token_params
    {
      "grant_type" => "authorization_code",
      "code" => request.params["code"],
      "client_id" => client.id,
      'redirect_uri' => callback_url
    }
  end
