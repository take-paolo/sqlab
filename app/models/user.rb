# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_practices, through: :bookmarks, source: :practice
  accepts_nested_attributes_for :authentications

  enum :role, {
    general: 0,
    admin: 10
  }

  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, length: { minimum: 8 }, confirmation: true, if: :new_record_or_changes_password
  validates :password_confirmation, presence: true, if: :new_record_or_changes_password

  def bookmark(practice)
    bookmark_practices << practice
  end

  def unbookmark(practice)
    bookmark_practices.destroy(practice)
  end

  private

  def new_record_or_changes_password
    new_record? || changes[:crypted_password]
  end
end
