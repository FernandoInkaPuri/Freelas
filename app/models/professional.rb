class Professional < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status_profile: { pending: 5, completed: 10 }
  has_one :profile, dependent: :destroy
  has_many :proposals, dependent: :nullify
  has_many :projects, through: :proposals
  has_many :feedbacks, dependent: :nullify
  has_many :professional_feedbacks, dependent: :nullify
  has_many :user_feedbacks, dependent: :nullify
end
