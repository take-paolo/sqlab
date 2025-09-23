# frozen_string_literal: true

module Samples
  module BookStores
    class BookSale < BookStoresRecord
      belongs_to :book
      belongs_to :store

      validates :book_id, uniqueness: { scope: :store_id }

      validates :price, presence: true, numericality: { only_integer: true }
      validates :stock, presence: true, numericality: { only_integer: true }
      validates :figure, presence: true, numericality: { only_integer: true }
    end
  end
end
