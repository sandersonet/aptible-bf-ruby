require 'aptible/billforward/response'

module Aptible
  module BillForward
    class Resource < Sawyer::Resource
      def self.all(query = {})
        client.get collection_path, { query: query }
      end

      def self.find(id)
        client.get("#{collection_path}/#{id}").first
      end

      def self.create(params, query = {})
        client.post collection_path, self.new(client.agent, params), { query: query }
      end

      def self.collection_path
        basename
      end

      def self.basename
        name.split('::').last.underscore.dasherize.pluralize
      end

      def self.client
        @client ||= Aptible::BillForward::Client.new
      end

      def client
        @client ||= Aptible::BillForward::Client.new
      end

      def href
        "#{collection_path}/#{id}"
      end

      def update(params = {})
        client.put href, self.new(client.agent, params)
      end

      def invoice
        return nil unless invoiceID
        Aptible::BillForward::Invoice.find(invoiceID)
      end

      def subscription
        return nil unless subscriptionID
        Aptible::BillForward::Subscription.find(subscriptionID)
      end

      # Get
      def self.by_subscription_id(subscriptionID, options = {})
        state = options[:active] ? '/active' : ''
        client.get(
          "#{collection_path}/#{subscriptionID}#{state}",
          { order: 'DESC', order_by: 'start' }
        )
      end
    end
  end
end

require 'aptible/billforward/resource/account'
require 'aptible/billforward/resource/invoice'
require 'aptible/billforward/resource/subscription'
require 'aptible/billforward/resource/usage'
require 'aptible/billforward/resource/usage_session'
require 'aptible/billforward/resource/usage_period'
require 'aptible/billforward/resource/units_of_measure'