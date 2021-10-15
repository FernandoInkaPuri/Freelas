class AddStatusProfileToProfessional < ActiveRecord::Migration[6.1]
  def change
    add_column :professionals, :status_profile, :integer, default: 5
  end
end
