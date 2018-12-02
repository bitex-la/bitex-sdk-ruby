module Bitex
  module Connections
    class Public < JsonApiClient::Connection
      def run(request_method, path, params: nil, headers: {}, body: nil)
        super(request_method, path, params: params, headers: custom_headers(headers), body: body)
      end

      protected

      def custom_headers(headers = {})
        headers.merge(version: VERSION)
      end
    end
  end
end