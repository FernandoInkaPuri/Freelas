class AddProfessionalRefToUserFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_feedbacks, :professional, null: false, foreign_key: true
  end
end
