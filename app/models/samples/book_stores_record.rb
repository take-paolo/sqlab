# frozen_string_literal: true

module Samples
  class BookStoresRecord < ApplicationRecord
    self.abstract_class = true

    DATABASE_NAME = SampleDatabaseDefinition.find_by(name: 'book_stores').name.to_sym

    connects_to database: { writing: DATABASE_NAME, reading: DATABASE_NAME }

    include Samples::Base
  end
end
