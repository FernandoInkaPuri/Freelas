class ProposalMailer < ApplicationMailer
    # default from: 'freelas@freelas.com' - sobrescreve o from com outro email
    def notify_new_proposal
        @proposal = params[:proposal]
        mail(to: @proposal.project.user.email, 
             subject:"Nova proposta para #{@proposal.project.title}")
    end
end