class AddOpenRegistrationToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :open_registration, :boolean, default: true
  end
end
