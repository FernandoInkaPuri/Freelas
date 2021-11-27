class FavoriteUser < ApplicationRecord
  belongs_to :user
  belongs_to :professional
  enum status_u: { preferred: 0, unpreferred: 5 }
end
