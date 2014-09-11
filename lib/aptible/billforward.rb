require 'gem_config'
require 'aptible/billforward/defaults'

module Aptible
  module BillForward
    include GemConfig::Base

    with_configuration do
      has :root_url,
          classes: String,
          default: ENV['BILLFORWARD_ROOT_URL'] || 'https://api.billforward.net'

      has :access_token,
          classes: String,
          default: ENV['BILLFORWARD_ACCESS_TOKEN'] || ''
    end
  end
end

require 'aptible/billforward/client'
