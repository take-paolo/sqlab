# frozen_string_literal: true

module Samples
  module Collections
    module BookStores
      class Event < BookStoresRecord
        validates :name, presence: true
        validates :max_num, presence: true, numericality: { only_integer: true }
      end
    end
  end
end
