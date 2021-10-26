class FavoriteProfessional < ApplicationRecord
  belongs_to :user
  belongs_to :professional
  enum status: {favorited: 0, unfavorited:5}
end
