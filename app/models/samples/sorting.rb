# frozen_string_literal: true

module Samples
  class Sorting
    def self.sort_by_associations(arr, result = [])
      arr_copy ||= Array.new(arr)
      return result if arr_copy.blank?

      top = arr_copy.shift
      associations = top.reflect_on_all_associations(:belongs_to)
      intesetion_values = associations.map(&:table_name) & arr_copy.map(&:table_name)

      if associations.present? && intesetion_values.present?
        arr_copy << top
        top = nil
      end

      result << top if top.present?
      sort_by_associations(arr_copy, result)
    end
  end
end
