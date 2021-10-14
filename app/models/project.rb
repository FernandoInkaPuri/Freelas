class Project < ApplicationRecord
    belongs_to :user
    validates :title, :description, :skills, :max_value, 
              :limit_date, :start_date, :end_date, presence: true
    validate :remote_or_presecial
    validate :limit_date_in_the_past
    validate :end_date_greater_than_start_date
    validate :start_date_in_the_past
    
    private
    def remote_or_presecial
        if modality != 0 && modality != 1
            errors.add(:modality, 'não pode ficar em branco. Selecione uma das opções!')
        end
    end

    def limit_date_in_the_past
        if limit_date < Date.today
            errors.add(:limit_date, 'não pode ser em datas passadas')
        end
    end

    def end_date_greater_than_start_date
        if start_date >= end_date
          errors.add(:end_date, 'deve ser maior que a data início')
        end
    end
    
    def start_date_in_the_past
        if start_date < Date.today
          errors.add(:start_date, 'não pode ser em datas passadas')
        end
    end

end
