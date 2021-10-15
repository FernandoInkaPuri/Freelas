class ProfileController < ApplicationController


    def new
        if current_professional.pending?
            @profile = Profile.new
        else
            redirect_to profile_path
        end
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.professional = current_professional
        if @profile.save   
            current_professional.completed!              
            redirect_to @profile      
        else
            render :new
        end
    end

    def show 
        if current_professional.pending?
            redirect_to new_profile_path
        else
            @profile = current_professional.profile
        end    
    end

    private

    def profile_params
        params.require(:profile).permit(:name, :social_name, :birth_date, 
                                        :formation, :description, :experience, :status_profile )
    end
end