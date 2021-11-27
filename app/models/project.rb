class Project < ApplicationRecord
  belongs_to :user
  validates :title, :description, :skills, :max_value,
            :limit_date, :start_date, :end_date, presence: true
  validate :remote_or_presecial
  validate :limit_date_in_the_past
  validate :end_date_greater_than_start_date
  validate :start_date_in_the_past
  has_many :proposals
  has_many :feedbacks

  private

  def remote_or_presecial
    errors.add(:modality, 'não pode ficar em branco. Selecione uma das opções!') if modality != 0 && modality != 1
  end

  def limit_date_in_the_past
    errors.add(:limit_date, 'não pode ser em datas passadas') if !limit_date.nil? && (limit_date < Date.today)
  end

  def end_date_greater_than_start_date
    errors.add(:end_date, 'deve ser maior que a data início') if !limit_date.nil? && (start_date >= end_date)
  end

  def start_date_in_the_past
    errors.add(:start_date, 'não pode ser em datas passadas') if !limit_date.nil? && (start_date < Date.today)
  end
end
