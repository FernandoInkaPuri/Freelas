class UserFeedback < ApplicationRecord
  belongs_to :professional
  belongs_to :user
  validates :opinion, :grade, presence: true
end
