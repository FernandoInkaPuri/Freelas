class Profile < ApplicationRecord
  belongs_to :professional
  has_one_attached :avatar
  validates :name, :social_name, :birth_date, :formation,
            :description, :experience, presence: true
end
