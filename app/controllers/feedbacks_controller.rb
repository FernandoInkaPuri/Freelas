class FeedbacksController < ApplicationController
    def new
        @feedbacks = Feedback.where("project_id = ?", params[:project_id])
        @project = Project.find(params[:project_id])
        @propostas = @project.proposals.where( status_proposal: 5)
        @propostas.each do |prop|
          if @feedbacks != []
            @feedbacks.each do |fb|
              if prop.professional_id != fb.professional_id
                @proposals << prop
              end
            end
          else
            @proposals = @project.proposals.where( status_proposal: 5)
          end
        end
        @feedback = Feedback.new
    end

    def create
        @feedback = Feedback.new(params.require(:feedback).permit(:feedback, :nota))
        @feedback.user = current_user
        @feedback.project = Project.find(params[:project_id])
        id = @prof
        @feedback.professional = Professional.find(params[:professional_id])
        if @feedback.save
            redirect_to new_project_feedback_path(@feedback.project.id), notice: "Feedback de #{@feedback.professional.profile.social_name} enviado com sucesso!"
        else
            render :new
        end
    end
end

 