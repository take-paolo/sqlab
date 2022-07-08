# frozen_string_literal: true

module Samples
  class QueryDefinition
    DEFAULT_VALID_QUERY = [
      %i[select into],
      %i[insert],
      %i[update],
      %i[delete]
    ].freeze
    private_constant :DEFAULT_VALID_QUERY

    DEFAULT_SYSTEM_INFO_PREFIX = %i[pg inet current has].freeze
    private_constant :DEFAULT_SYSTEM_INFO_PREFIX

    class << self
      def build_valid_query_regex(*parts)
        parts += DEFAULT_VALID_QUERY
        parts = parts.map { |part| build_query_regex(part) }
        parts = parts.map { |part| /#{part}/i }
        /#{Regexp.union(*parts)}/u
      end

      def build_system_info_prefix_regex(*parts)
        parts += DEFAULT_SYSTEM_INFO_PREFIX
        parts = parts.join('|')
        parts = /#{parts}/i
        parts = "#{parts}_[a-zA-Z0-9_]*"
        /#{Regexp.new(parts)}/u
      end

      private

      def build_query_regex(arr)
        keyword = arr.shift
        exceptions = arr

        keyword_regex = build_keyword_regex(keyword)
        exceptions_regex = build_exceptions_regex(exceptions)

        keyword_regex + (exceptions_regex || '')
      end

      def build_keyword_regex(keyword)
        keyword.to_s.gsub('_', '\s+')
      end

      def build_exceptions_regex(exceptions)
        return if exceptions.blank?

        exceptions = exceptions.join('|')
        "(?!.+\\b(?:#{exceptions})\\b)"
      end
    end
  end
end
