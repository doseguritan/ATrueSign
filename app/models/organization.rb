class Organization < ApplicationRecord
  has_many :organizations_users
  has_many :users, through: :organizations_users

  validates :name, presence: true
  validates :domain, presence: true
end
