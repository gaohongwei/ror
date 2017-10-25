require 'vcr'

RSpec.configure do |config|
  config.include Helpers
  config.include ResourceHelpers
  config.include RspecLoginHelpers
  config.include WeworkActivationHelpers

  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.before(:each) do
    time_now = "1508523649.04283"
    allow_any_instance_of(LoginService).to receive(:current_time).and_return(time_now)      
  end  
  config.before(:all) do
    Tenant.set_current_from_name('common')
    time_now = "1508523649.04283"
    allow_any_instance_of(LoginService).to receive(:current_time).and_return(time_now)            
  end
end

SKIP_REQUEST_PARAMS= [] #%w(time signature)

def request_match?(req1,req2)
  return false unless req1.method == req2.method
  return false unless req1.uri === req2.uri  
  body1 = req1.body
  body2 = req2.body   
  return true if body1 === body2
  params1 = URI.decode_www_form(body1).to_h
  params2 = URI.decode_www_form(body2).to_h
  SKIP_REQUEST_PARAMS.each do |key|
    params1.delete(key)
    params2.delete(key)
  end
  params1.sort_by{|k,v|k}.to_s === params2.sort_by{|k,v|k}.to_s
end

VCR.configure do |c|
  c.register_request_matcher :request_matcher do |req1, req2|
    request_match?(req1, req2)
  end
 
  vcr_dir = Rails.root.join("tmp", "vcr")
  #FileUtils.rm_rf(vcr_dir)  
  c.cassette_library_dir  = vcr_dir
  c.hook_into :webmock  
  c.allow_http_connections_when_no_cassette = true  
  c.ignore_localhost = true  
  #c.ignore_hosts '127.0.0.1', 'localhost'
  # c.before_record do |i|
  #   i.request.uri.sub!(/:\d+/, ':3000')
  # end
  # c.allow_playback_repeats =true 
  #c.configure_rspec_metadata!  
  c.debug_logger = File.open(Rails.root.join(vcr_dir,'vcr.log'), 'w')
  c.default_cassette_options = {
    allow_playback_repeats: true,
    match_requests_on: [:request_matcher]
  }  
end
module Capybara
  class Session
    alias_method :visit_org, :visit
    def visit(*args, &block)
      vcr_tag = args.first.split('?').first[1..-1]
      vcr_tag = "/page/#{vcr_tag}"
      puts "vcr_tag: #{vcr_tag}, #{args.first}"
      VCR.use_cassette(vcr_tag) do
        visit_org(*args, &block)
      end
    end
  end
end
module Capybara
  module Node
    class Element
      alias_method :trigger_org, :trigger
      def trigger(*args, &block)
        action = args.first
        vcr_tag = "/trigger/#{action}"
        puts "vcr_tag: #{vcr_tag}"
        binding.pry
        VCR.use_cassette(vcr_tag) do
          trigger_org(*args, &block)
        end
      end
    end
  end
end
# def vcr_visit(path)
#   vcr_tag = path.split('?').first
#   VCR.use_cassette vcr_tag do
#     visit  path
#   end
# end
# WebMock.after_request do |request, response|
#   ap request
#   puts "request.inspect: http://#{request.uri.host}#{request.uri.path}\n"
#   # puts "response #{response.inspect}\n\n" 
#   # puts "request.stubbed_by_vcr? : #{request.stubbed_by_vcr?}"
#   ap response

#   puts "\n\n\n"
# end
