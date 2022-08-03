# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  included do
    before_validation :set_order_number, on: :create

    scope :sort_by_order_number, -> { order(:order_number) }

    def set_order_number
      self.order_number = self.class.maximum(:order_number).to_i + 1
    end

    class << self
      def update_order(ids_arr)
        ids_arr.each do |ids|
          ids.each_with_index do |id, index|
            record = find(id)
            record.update!(order_number: index)
          end
        end
      end
    end
  end
end
