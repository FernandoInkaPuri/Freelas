class ProposalMailerPreview < ActionMailer::Preview
    # default from: 'freelas@freelas.com' - sobrescreve o from com outro email
    def notify_new_proposal
        proposta = FactoryBot.create(:proposal)
        ProposalMailer.with(proposal: proposta ).notify_new_proposal
    end
end