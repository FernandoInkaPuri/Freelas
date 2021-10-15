class ProjectsController < ApplicationController
   def new
      @project = Project.new()
   end

   def create
      @project = Project.new(parametros)
      @project.user = current_user
      if @project.save
         redirect_to root_path
      else
         render :new
      end
   end
   
   def show 
      if current_professional.pending?
         redirect_to new_profile_path
      else
         @project = Project.find(params[:id])
      end  
   end

   


   private

   def parametros
      params.require(:project).permit(:title, :description, :skills,:modality, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
end