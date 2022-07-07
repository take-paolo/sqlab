# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  included do
    before_validation :set_order_number, on: :create

    scope :sort_by_order_number, -> { order(:order_number) }

    def set_order_number
      self.order_number = self.class.maximum(:order_number).to_i + 1
    end
  end
end
