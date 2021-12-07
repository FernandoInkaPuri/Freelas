class ProfessionalFeedback < ApplicationRecord
    belongs_to :user
    belongs_to :professional
    validates :opinion, :grade, presence: true
end
