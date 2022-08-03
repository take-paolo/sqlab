# frozen_string_literal: true

module Samples
  class QueryValidator
    VALID_QUERY = QueryDefinition.build_valid_query_regex
    private_constant :VALID_QUERY

    SYSTEM_INFO_PREFIX = QueryDefinition.build_system_info_prefix_regex
    private_constant :SYSTEM_INFO_PREFIX

    class << self
      def validate(query)
        return if query.blank?
        return unless invalid_query?(query) || system_info_prefix?(query)

        raise "ERROR:  invalid keywords or syntax error, at \"#{query}\""
      end

      private

      def invalid_query?(query)
        !VALID_QUERY.match?(query)
      end

      def system_info_prefix?(query)
        SYSTEM_INFO_PREFIX.match?(query)
      end
    end
  end
end
