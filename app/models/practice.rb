# frozen_string_literal: true

class Practice < ApplicationRecord
  include Sortable

  has_many :sample_tables, dependent: :destroy
  belongs_to :chapter

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :sample_database_id, presence: true, numericality: { only_integer: true }
  validates :display_er_diagram, inclusion: { in: [true, false] }
  validates :enabled, inclusion: { in: [true, false] }
  validates :published, inclusion: { in: [true, false] }
  validates :requires_auth, inclusion: { in: [true, false] }
  validates :order_number, presence: true, numericality: { only_integer: true }

  scope :published, -> { where(published: true) }

  def update_with_sample_tables!(practice_params, new_sample_table_ids)
    update!(practice_params)

    old_sample_table_ids = sample_tables.map(&:uid)

    (old_sample_table_ids - new_sample_table_ids).each do |id|
      sample_tables.find_by(uid: id).destroy!
    end
    (new_sample_table_ids - old_sample_table_ids).each do |id|
      sample_tables.create!(uid: id)
    end
  end
end
