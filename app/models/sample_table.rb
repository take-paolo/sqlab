# frozen_string_literal: true

class SampleTable < ApplicationRecord
  belongs_to :practice

  validates :uid, presence: true, uniqueness: { scope: :practice_id }
end
