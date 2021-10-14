class ProfileController < ApplicationController
    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.professional = current_professional
        if @profile.save                 
            redirect_to @profile
        else
            render :new
        end
    end

    def show 
        @profile = current_professional.profile
    end


    private

    def profile_params
        params.require(:profile).permit(:name, :social_name, :birth_date, 
                                        :formation, :description, :experience )
    end
end