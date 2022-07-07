# frozen_string_literal: true

module Samples
  module Collections
    class BookStoresRecord < DataModelsRecord
      self.abstract_class = true

      DATABASE_NAME = :book_stores

      connects_to database: { writing: DATABASE_NAME, reading: DATABASE_NAME }

      include Samples::Collections::Base
    end
  end
end
