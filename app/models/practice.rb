# frozen_string_literal: true

class Practice < ApplicationRecord
  include Sortable

  has_many :sample_tables, dependent: :destroy
  belongs_to :chapter

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :sample_database_uid, presence: true
  validates :display_er_diagram, inclusion: { in: [true, false] }
  validates :enabled, inclusion: { in: [true, false] }
  validates :published, inclusion: { in: [true, false] }
  validates :requires_auth, inclusion: { in: [true, false] }
  validates :order_number, presence: true, numericality: { only_integer: true }

  scope :published, -> { where(published: true) }
end
