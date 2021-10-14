class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :social_name
      t.date :birth_date
      t.string :formation
      t.string :description
      t.string :experience

      t.timestamps
    end
  end
end
