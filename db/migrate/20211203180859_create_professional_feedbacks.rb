class CreateProfessionalFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :professional_feedbacks do |t|
      t.string :opinion
      t.integer :grade

      t.timestamps
    end
  end
end
