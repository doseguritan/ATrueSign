class Project < ApplicationRecord
  # Add organization association by default
  acts_as_tenant :organization
  belongs_to :organization
  enum :status, [ :todo, :inprogress, :completed ]
  belongs_to :user, foreign_key: :assignee_id
end
