# frozen_string_literal: true

module Samples
  class DataModelsRecord < ApplicationRecord
    self.abstract_class = true

    connects_to database: { writing: :data_models, reading: :data_models }

    MODULE_PREFIXES = %w[samples collections].freeze
  end
end
