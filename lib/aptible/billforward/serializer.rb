require 'pry'
module Aptible
  module BillForward
    class Serializer < Sawyer::Serializer
      def encode_object(data)
        case data
        when Hash then encode_hash(data)
        when Array then data.map { |o| encode_object(o) }
        else
          wrap_hash_with_type data
        end
      end

      def wrap_hash_with_type(hash)
        return hash unless hash.class.basename
        body = {}
        body[hash.class.basename.underscore.camelize(:lower).pluralize] = [hash]
        body
      end

      def time_field?(key, value)
        time_fields = %w(created updated start stop initalPeriodStart
                         currentPeriodStart currentPeriodEnd)
        value && time_fields.include?(key)
      end
    end
  end
end
