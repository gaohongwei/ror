require 'logger'

module ApiBase
  extend ActiveSupport::Concern
  class_methods do
    def request(method, url, payload, header = headers)
      execute(2) do
        connection.public_send(method, url, payload, header)
      end
    end

    def connection
      Faraday.new do |conn|
        conn.use CustomErrors
        conn.use Faraday::Adapter::NetHttp
        conn.request :url_encoded
        conn.options[:open_timeout] = 2
        conn.options[:timeout] = 5
      end
    end

    def execute(retries = 5, &block)
      return block.call
    rescue RuntimeError => e # if error 500
      if retries > 0
        retries -= 1
        sleep 1
        retry
      end
      return logger_error(e)
    rescue Faraday::Error => e # if webservice not accessible
      return logger_error(e)
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def logger_error(e)
      error_header = 'ERROR - ServiceNotFound'
      Rails.logger.error "#{error_header} : #{e}"
      OpenStruct.new(status: 500, details: "#{e}")
    end
  end
end
