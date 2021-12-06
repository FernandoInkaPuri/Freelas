class CreateUserFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_feedbacks do |t|
      t.string :opinion
      t.integer :grade

      t.timestamps
    end
  end
end
