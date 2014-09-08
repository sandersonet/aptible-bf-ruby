module Aptible
  module BillForward
    module Defaults
      def access_token
        Aptible::BillForward.configuration.access_token
      end

      def api_endpoint
        Aptible::BillForward.configuration.root_url
      end

      def user_agent
        "aptible-billforward Ruby Gem #{Aptible::BillForward::VERSION}"
      end

      def media_type
        'application/json'
      end

      def connection_options
        {
          headers: {
            accept: media_type,
            user_agent: user_agent
          }
        }
      end
    end
  end
end
