class AddProfessionalRefToProfessionalFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :professional_feedbacks, :professional, null: false, foreign_key: true
  end
end
