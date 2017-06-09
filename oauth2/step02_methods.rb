########## deep_symbolize, string key => symbol key ##########
def deep_symbolize(options)
  hash = {}
  options.each do |key, value|
    hash[key.to_sym] = value.is_a?(Hash) ? deep_symbolize(value) : value
  end
  hash
end

options = {
  authorize_url: "authorize_url_value",
  token_url: "token_url_value",
  'nested' => { 'nested_a' => 'nested_a_value'}
}
h = deep_symbolize(options)
h has this value
{
  authorize_url: "authorize_url_value",
  token_url: "token_url_value",
  nested: { nested_a: 'nested_a_value'}
}
