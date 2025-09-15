# frozen_string_literal: true

module Samples
  module BookStores
    class Event < BookStoresRecord
      include Samples::TemporaryTableable

      validates :name, presence: true
      validates :max_num, presence: true, numericality: { only_integer: true }
    end
  end
end
