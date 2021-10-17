class HomeController < ApplicationController
    def index
        @projects = Project.where(open: true, open_registration: true)
        @proposals = Proposal.where(professional: current_professional, status_proposal: 5)
    end
end