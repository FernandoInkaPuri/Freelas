class ProposalsController < ApplicationController
  before_action :authenticate_professional!, only: %i[new create destroy]
  before_action :authenticate_user!, only: %i[accept reject]
  before_action :authenticate_person, only: [:show]

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = current_professional.proposals.new(proposal_params)
    @proposal.project = Project.find(params[:project_id])
    if @proposal.save
      ProposalMailer.with(proposal: @proposal).notify_new_proposal.deliver_now
      redirect_to @proposal, notice: 'Proposta enviada com sucesso!'
    else
      render :new
    end
  end

  def show
    prop = Proposal.find(params[:id])
    project = prop.project
    if user_signed_in?
      return @proposal = prop if current_user == project.user
    elsif professional_signed_in?
      return @proposal = prop if current_professional == prop.professional
    end
  end

  def accept
    project = Proposal.find(params[:id]).project
    return unless current_user == project.user

    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to @proposal.project, notice: 'Proposta aceita com sucesso!'
  end

  def reject
    project = Proposal.find(params[:id]).project
    return unless current_user == project.user

    @proposal = Proposal.find(params[:id])
    @proposal.rejected!
    @proposal.update!({ justify: params[:justify] })
    redirect_to @proposal.project, notice: 'Proposta rejeitada com sucesso!'
  end

  def destroy
    prop = Proposal.find(params[:id])
    return unless current_professional == prop.professional

    prop.destroy
    redirect_to root_path, notice: 'Proposta cancelada com sucesso!'
  end

  private

  def proposal_params
    params.require(:proposal).permit(:reason, :hour_value,
                                     :hours_week, :expectation, :justify, :code)
  end
end
