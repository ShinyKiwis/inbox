module HttpEngine
  class Engine
    def initialize(base_url, params: {})
      @conn ||= Faraday.new(url: base_url, params: params, **default_params) do |config|
        config.request :retry, retry_options
        config.response :raise_error
        config.response :logger, Rails.logger, logger_options
        config.adapter :net_http_persistent
      end
    end

    def get(endpoint, params: {}, headers: {})
      request(:get, endpoint, params, headers)
    end

    private

    def default_params
      {
        request: {
          open_timeout: 1,
          read_timeout: 5
        },
        headers: {
          'Content-Type': ContentTypes::JSON
        }
      }
    end

    def retry_options
      {
        max: 5,                 # Retry a failed request up to 5 times
        interval: 0.5,          # First retry after 0.5 seconds
        backoff_factor: 2,      # Double the delay for each subsequent retry
        retry_statuses: [429],  # Retry only when we get 429 request
        methods: [:get]         # Retry only GET requests
      }
    end

    def logger_options
      {
        headers: true,
        bodies: true,
        log_level: :debug
      }
    end

    def request(method, endpoint, params, headers)
      handle_errors do
        handle_response(@conn.public_send(method, endpoint, params, headers))
      end
    end

    def handle_errors
      yield
    rescue Faraday::Error => e
      Honeybadger.notify(e)
    end

    def handle_response(response)
      response
    end
  end
end

