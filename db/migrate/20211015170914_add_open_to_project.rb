class AddOpenToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :open, :boolean, default: true
  end
end
