# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :practice

  validates :user_id, uniqueness: { scope: :practice_id }
end
