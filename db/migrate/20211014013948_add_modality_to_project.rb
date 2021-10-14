class AddModalityToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :modality, :integer
  end
end
