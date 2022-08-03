# frozen_string_literal: true

module Samples
  module Collections
    module BookStores
      class BookAuthor < BookStoresRecord
        belongs_to :book
        belongs_to :author

        validates :book_id, uniqueness: { scope: :author_id }
      end
    end
  end
end
