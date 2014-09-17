require 'aptible/billforward/response'

module Aptible
  module BillForward
    class Resource < Sawyer::Resource
      def self.all
        client.get collection_path
      end

      def self.find(id)
        client.get("#{collection_path}/#{id}").first
      end

      def self.create(params)
        client.post collection_path, self.new(client.agent, params)
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
    end
  end
end

require 'aptible/billforward/resource/account'
require 'aptible/billforward/resource/invoice'
require 'aptible/billforward/resource/subscription'
require 'aptible/billforward/resource/usage_session'