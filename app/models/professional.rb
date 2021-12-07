class Professional < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status_profile: { pending: 5, completed: 10 }
  has_one :profile
  has_many :proposals
  has_many :projects, through: :proposals
  has_many :feedbacks
  has_many :professional_feedbacks
  has_many :user_feedbacks
end
