class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :professional
  enum status_proposal: { not_rated: 0, accepted: 5, rejected: 10 }
  before_create :generate_code
  validates :code, uniqueness: true
  validates :reason, :hour_value, :hours_week, :expectation, presence: true
  validates :hour_value, :hours_week, numericality: true

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
    generate_code if Proposal.exists?(code: code)
  end
end
