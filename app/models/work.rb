# frozen_string_literal: true

class Work < ApplicationRecord
  include Sortable

  has_many :chapters, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z_]+\z/, message: 'は半角英字、アンダースコアのみが使えます' }
  validates :description, presence: true
  validates :enabled, inclusion: { in: [true, false] }
  validates :published, inclusion: { in: [true, false] }
  validates :order_number, presence: true, numericality: { only_integer: true }

  scope :published, -> { where(published: true) }
end
