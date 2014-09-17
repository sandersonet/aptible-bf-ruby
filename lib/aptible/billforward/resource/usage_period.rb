module Aptible
  module BillForward
    class UsagePeriod < Resource
       def self.by_subscription_id(options = {})
        state = options[:active] ? '/active' : ''
        client.get(
          "#{collection_path}/#{options[:subscription_id]}#{state}",
          { order: 'DESC', order_by: 'start' }
        )
      end
    end
  end
end