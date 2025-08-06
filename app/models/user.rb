class User < ApplicationRecord
  has_paper_trail

  has_secure_password

  has_many :sessions, dependent: :destroy

  has_many :checklists, dependent: :destroy

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }

  validates_with EmailAddress::ActiveRecordValidator, field: :email_address

  normalizes :email_address, with: ->(email_address) { email_address.strip.squish.downcase }
end
