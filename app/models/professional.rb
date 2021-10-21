class Professional < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile       
  has_many :proposals
  enum status_profile: { pending: 5, completed: 10}
  has_many :feedbacks
end
