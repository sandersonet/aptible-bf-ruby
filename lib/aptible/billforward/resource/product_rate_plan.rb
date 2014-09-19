module Aptible
  module BillForward
    class ProductRatePlan < Resource
      def self.basename
        'product-rate-plans'
      end

      def serialize
        to_attrs
      end

      def self.by_account_id(account_id, params = {})
        client.get "#{collection_path}/account/#{account_id}", params
      end
    end
  end
end