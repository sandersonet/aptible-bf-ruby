require 'securerandom'

module Aptible
  module BillForward
    class UsageSession < Resource
      def self.find(subscriptionID, sessionID)
        self.by_subscription_id(subscriptionID).find do |session|
          session.sessionID == sessionID
        end
      end

      def self.create(params)
        client.post "#{collection_path}/start", self.new(client.agent, params)
      end

      def self.stop(params)
        client.post "#{collection_path}/stop", self.new(client.agent, params)
      end

      def self.generate_session_id
        SecureRandom.uuid
      end

      def create_usage(usage_params)
        usage = usage_params.merge(
          self.to_attrs.slice(:organizationID, :subscriptionID,
                              :sessionID, :uom)
        )
        Aptible::BillForward::Usage.create usage
      end
    end
  end
end
