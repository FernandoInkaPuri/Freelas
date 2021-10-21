class Feedback < ApplicationRecord
  belongs_to :project
  belongs_to :professional
  belongs_to :user
end
