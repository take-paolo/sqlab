# frozen_string_literal: true

module Samples
  class QueryParser
    class << self
      def call(queries)
        queries = remove_comments(queries)
        queries = replace_newline_with_space(queries)
        queries.split(';').reject(&:blank?)
      end

      private

      SINGLE_LINE_COMMENT_REGEX = /(?:--.*\n)/
      MULTI_LINE_COMMENT_REGEX = %r{/\*(?:[^*]|\*[^/])*\*/}m

      COMMENT_REGEX = Regexp.union(SINGLE_LINE_COMMENT_REGEX, MULTI_LINE_COMMENT_REGEX)

      def remove_comments(queries)
        queries.gsub(COMMENT_REGEX, '')
      end

      def replace_newline_with_space(queries)
        queries.tr("\n/", ' ')
      end
    end
  end
end
