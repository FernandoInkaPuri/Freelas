class Profile < ApplicationRecord
  belongs_to :professional
  has_one_attached :avatar
end
