# frozen_string_literal: true

module Samples
  module Collections
    module BookStores
      class BookCategory < BookStoresRecord
        belongs_to :book
        belongs_to :category

        validates :book_id, uniqueness: { scope: :category_id }
      end
    end
  end
end
