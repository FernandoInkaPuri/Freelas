class CreateFavoriteProfessionals < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_professionals do |t|
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
