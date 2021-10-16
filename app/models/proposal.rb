class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :professional
  enum status_proposal: { not_rated:0, accepted: 5, rejected:10 }
  validates :reason, :hour_value, :hours_week, :expectation, 
            :status_proposal, presence: true
  validates :hour_value, :hours_week, numericality: true


end
