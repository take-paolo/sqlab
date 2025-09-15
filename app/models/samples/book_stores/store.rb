# frozen_string_literal: true

module Samples
  module BookStores
    class Store < BookStoresRecord
      has_many :book_sales, dependent: :destroy
      has_many :books, through: :book_sales

      validates :name, presence: true
      validates :holiday, presence: true
    end
  end
end
