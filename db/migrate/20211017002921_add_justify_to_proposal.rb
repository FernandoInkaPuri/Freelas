class AddJustifyToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :justify, :string
  end
end
