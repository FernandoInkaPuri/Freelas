class Project < ApplicationRecord
    belongs_to :user
    validates :title, :description, :skills, :max_value, 
              :limit_date, :start_date, :end_date, presence: true
end
