# frozen_string_literal: true

module Samples
  class ModelTable < DataModelsRecord
    belongs_to :model_database

    validates :name, presence: true, uniqueness: { scope: :model_database_id }

    def to_class
      [*MODULE_PREFIXES, model_database.name, name].join('/').classify.constantize
    end
  end
end
