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


   private

   def parametros
      params.require(:project).permit(:title, :description, :skills, :max_value, 
                                      :limit_date, :start_date, :end_date)
   end
end