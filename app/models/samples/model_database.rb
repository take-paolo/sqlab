# frozen_string_literal: true

module Samples
  class ModelDatabase < DataModelsRecord
    has_many :model_tables, dependent: :destroy

    validates :name, presence: true, uniqueness: true

    def to_class
      [*MODULE_PREFIXES, "#{name}_record"].join('/').classify.constantize
    end
  end
end
