class ProposalsController < ApplicationController
    before_action :authenticate_professional!, only: [:new, :create]

    def index
        @proposals = current_professional.proposals
    end
    def new
        @proposal = Proposal.new
        @project = Project.find(params[:project_id])
    end
    
    def create
        @proposal = current_professional.proposals.new(proposal_params)
        @proposal.project = Project.find(params[:project_id])
        if @proposal.save
            redirect_to @proposal , notice: 'Proposta enviada com sucesso!'
        else
            render :new
        end
    end

    def show
        @proposal = Proposal.find(params[:id])
    end

    private 

    def proposal_params
        params.require(:proposal).permit(:reason, :hour_value,
                                         :hours_week, :expectation, :project_id, :professional_id )
        
    end
end