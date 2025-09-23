# frozen_string_literal: true

module Samples
  module BookStores
    class Book < BookStoresRecord
      has_many :book_authors, dependent: :destroy
      has_many :authors, through: :book_authors

      has_many :book_categories, dependent: :destroy
      has_many :categories, through: :book_categories

      has_many :book_sales, dependent: :destroy
      has_many :stores, through: :book_sales

      validates :name, presence: true
      validates :release_year, numericality: { only_integer: true }, allow_blank: true
      validates :total_page, presence: true, numericality: { only_integer: true }
    end
  end
end
