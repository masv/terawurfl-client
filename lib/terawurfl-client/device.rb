class TerawurflClient::Device
  attr_reader :user_agent

  def initialize(user_agent)
    unless user_agent.is_a?(String)
      raise(ArgumentError, "user_agent must be string")
    end

    @user_agent = user_agent
  end

  def capabilities
    @capabilities ||= get_capabilities
  end

  private

  def get_capabilities(*caps)
    uri = URI(TerawurflClient::Config.api_url)
    params = { :format => "json",
               :ua => @user_agent,
               :search => caps.join("|") }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

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
