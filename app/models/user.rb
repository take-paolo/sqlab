# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  enum role: {
    general: 0,
    admin: 10
  }

  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, length: { minimum: 8 }, confirmation: true, if: :new_record_or_changes_password
  validates :password_confirmation, presence: true, if: :new_record_or_changes_password

  private

  def new_record_or_changes_password
    new_record? || changes[:crypted_password]
  end
end
