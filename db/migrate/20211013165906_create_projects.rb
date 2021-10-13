class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :skills
      t.decimal :max_value
      t.date :limit_date
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
