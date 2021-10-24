class Feedback < ApplicationRecord
  belongs_to :project
  belongs_to :professional
  belongs_to :user
  enum feedback_type: { nothing_f: 0, prof_f: 5, user_f:10, project_f:15}
end
