module Aptible
  module BillForward
    class Usage < Resource
      def self.basename
        'usage'
      end

      def self.create(params)
        client.post "#{collection_path}/create", self.new(client.agent, params)
      end
    end
  end
end