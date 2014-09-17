module Aptible
  module BillForward
    class Exception < ::StandardError
    end

    class ResponseError < Exception
    end

    class ResourceNotFoundError < ResponseError; end
  end
end
