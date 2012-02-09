module TerawurflClient
  module Device
    @mocks = ActiveSupport::HashWithIndifferentAccess.new

    def self.new(user_agent)
      if TerawurflClient.mock?
        TerawurflClient::Device::Mock.new(user_agent)
      else
        TerawurflClient::Device::Real.new(user_agent)
      end
    end

    def self.mock(user_agent, capabilities)
      @mocks[user_agent] = capabilities
    end

    def self.unmock(user_agent)
      @mocks.delete(user_agent)
    end

    def self.mocks
      @mocks
    end

    class Real
      attr_reader :user_agent

      def initialize(user_agent)
        @user_agent = user_agent
        @api_url = TerawurflClient::Config.api_url

        unless user_agent.is_a?(String)
          raise(ArgumentError, "user_agent must be string")
        end

        if !@api_url && !TerawurflClient.mock?
          raise(TerawurflClient::ConnectionError, "No API URL configured.")
        end

      end

      def capabilities
        @capabilities ||= get_capabilities
      end

      private

      def get_capabilities
        uri = URI(TerawurflClient::Config.api_url)
        params = { :format => "json",
                   :ua => @user_agent }
        uri.query = URI.encode_www_form(params)

        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 2 # seconds
        http.read_timeout = 2 # seconds
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        if response.is_a?(Net::HTTPSuccess)
          begin
            parsed = Yajl::Parser.parse response.body
            capabilities = ActiveSupport::HashWithIndifferentAccess.new(parsed["capabilities"])
            capabilities
          rescue
            raise TerawurflClient::InvalidResponseData
          end
        else
          raise TerawurflClient::ConnectionError, "#{response.code} #{response.message}"
        end
      end
    end

    class Mock < Real
      private

      def get_capabilities
        TerawurflClient::Device.mocks[user_agent].presence ||
          ActiveSupport::HashWithIndifferentAccess.new
      end
    end
  end
end
