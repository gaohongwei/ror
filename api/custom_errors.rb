require 'faraday'
require 'colorize'
class CustomErrors < Faraday::Response::Middleware
  def call(env)
    Rails.logger.debug("\nAPI logs----------#{Time.zone.now}---------------#{Rails.env}-----------------------------".yellow)
    Rails.logger.debug("Request:
    Method: #{env[:method]}
    Url: #{env[:url]}
    Headers: #{env[:request_headers]}
    Body: #{env[:body]}")

    super
  end

  def on_complete(env)
    body = env[:response_headers]['content-type'].eql?('application/octet-stream') ? env[:body].size : env[:body]
    Rails.logger.debug("\nResponse:
    Status: #{env[:status]}
    Headers: #{env[:response_headers]}
    Body: #{body}")

    case env[:status]
    when 500 then fail 'Internal Server Error'
    end
  end
end
