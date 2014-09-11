module Aptible
  module BillForward
    class Client
      module Invoices
        def invoices(options = {})
          get 'invoices', options
        end
      end
    end
  end
end
