# frozen_string_literal: true

class Chapter < ApplicationRecord
  include Sortable

  has_many :practices, dependent: :destroy
  belongs_to :work

  validates :name, presence: true
  validates :order_number, presence: true, numericality: { only_integer: true }

  scope :with_practice, lambda {
    includes(practices: :bookmarks)
      .references(:practices)
      .merge(Practice.published)
      .merge(Practice.sort_by_order_number)
  }
end
