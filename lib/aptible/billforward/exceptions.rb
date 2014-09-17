module Aptible
  module BillForward
    class Exception < ::StandardError
      attr_accessor :cause

      def initialize(message, attrs = {})
        self.cause = attrs[:cause]
        super(message)
      end
    end

    class ResponseError < Exception
      attr_accessor :response
      attr_accessor :body

      def initialize(message, attrs = {})
        self.response = attrs[:response]
        self.body = attrs[:body]

        if self.body.present? && self.body.key?(:errorMessage)
          error = self.body[:errorMessage]
          message = "#{message} (#{error})"
        elsif self.response
          message = "#{message} (\"#{self.response.inspect}\")"
        end

        super(message, attrs)
      end
    end

    class ResourceNotFoundError < ResponseError; end
  end
end
