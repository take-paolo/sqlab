# frozen_string_literal: true

module Samples
  module BookStores
    class Category < BookStoresRecord
      has_many :book_categories, dependent: :destroy
      has_many :books, through: :book_categories

      validates :name, presence: true
    end
  end
end
