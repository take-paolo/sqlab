# frozen_string_literal: true

module Samples
  class QueryValidator
    VALID_QUERY_PATTERN = /\A\s*(select(?!.*\binto\b)|insert|update|delete)\b/i
    private_constant :VALID_QUERY_PATTERN

    SYSTEM_INFO_PATTERN = /\b(pg_|inet_|current_|has_|txid_|information_schema\.|set_config\()/i
    private_constant :SYSTEM_INFO_PATTERN

    class << self
      def validate(query)
        return if query.blank?
        return unless invalid_query?(query) || system_info_pattern?(query)

        raise "ERROR:  invalid keywords or syntax error, at \"#{query}\""
      end

      private

      def invalid_query?(query)
        !VALID_QUERY_PATTERN.match?(query)
      end

      def system_info_pattern?(query)
        SYSTEM_INFO_PATTERN.match?(query)
      end
    end
  end
end
