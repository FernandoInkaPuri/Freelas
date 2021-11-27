require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  context 'new proposal' do
    it 'should notify user' do
      trabalhador = Professional.create!(email: 'tupac@amaru.com', password: '123456', status_profile: 10)
      Profile.create!(name: 'Tupac', social_name: 'Tupac Shakur',
                      birth_date: '10/10/1998', formation: 'Ciencia da computação',
                      description: 'Eu sou um artista de codigo',
                      experience: '3 anos dev ruby', professional: trabalhador)
      contratador = User.create!(email: 'Amy@whinehouse.com', password: '123456')
      projeto = create(:project, title: 'Projeto Marketplace', description: 'Projeto top',
                                 skills: 'Ruby on rails',
                                 limit_date: 2.weeks.from_now.to_date.to_s, start_date: 3.weeks.from_now.to_date.to_s,
                                 end_date: 2.months.from_now.to_date.to_s, user: contratador)
      proposta = Proposal.create!(reason: 'Trabalhar', hour_value: '60',
                                  hours_week: '10', expectation: 'Dinheirinhos',
                                  project: projeto, professional: trabalhador, status_proposal: 5)
      mail = ProposalMailer.with(proposal: proposta).notify_new_proposal
      expect(mail.to).to eq ['amy@whinehouse.com']
      expect(mail.from).to eq ['nao-responda@freelas.com']
      expect(mail.subject).to eq "Nova proposta para #{projeto.title}"
      expect(mail.body).to include "Seu projeto 'Projeto Marketplace' recebeu uma proposta de tupac@amaru.com"
    end
  end
end
