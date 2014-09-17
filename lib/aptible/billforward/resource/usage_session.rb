require 'securerandom'

module Aptible
  module BillForward
    class UsageSession < Resource
      def self.create(params)
        client.post "#{collection_path}/start", self.new(client.agent, params)
      end

      def self.stop(params)
        client.post "#{collection_path}/stop", self.new(client.agent, params)
      end

      def self.by_subscription_id(options = {})
        state = options[:active] ? '/active' : ''
        client.get(
          "#{collection_path}/#{options[:subscription_id]}#{state}",
          { order: 'DESC', order_by: 'start' }
        )
      end

      def self.generate_session_id
        SecureRandom.uuid
      end
    end
  end
end