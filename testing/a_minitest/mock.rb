# Mock
  MyAPI.any_instance.stubs(:call).returns(api_response)
  AController.any_instance.stubs(:sso_token_valid?).returns(true)
