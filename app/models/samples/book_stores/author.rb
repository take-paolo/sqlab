# frozen_string_literal: true

module Samples
  module BookStores
    class Author < BookStoresRecord
      has_many :book_authors, dependent: :destroy
      has_many :books, through: :book_authors

      validates :name, presence: true
      validates :gender, presence: true, inclusion: { in: %w[男性 女性 不明] }
    end
  end
end
