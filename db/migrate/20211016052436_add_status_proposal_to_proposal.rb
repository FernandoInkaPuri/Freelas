class AddStatusProposalToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :status_proposal, :integer, default: 0
  end
end
