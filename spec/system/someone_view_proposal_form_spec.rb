require 'rails_helper'

describe 'Someone view proposal form' do
  context 'professional view proposal' do
    it 'and fills wrong ' do
      trabalhador = create(:professional, status_profile: 10)
      create(:profile, professional: trabalhador)
      contratador = create(:user)
      projeto = create(:project, user: contratador)

      login_as trabalhador, scope: :professional
      visit root_path
      click_on projeto.title.to_s
      click_on 'Candidatar para projeto'
      fill_in 'Motivo:', with: ''
      fill_in 'Valor/hora', with: 'churrasco'
      fill_in 'Horas disponíveis', with: 'batata'
      fill_in 'Expectativa', with: ''
      click_on 'Enviar proposta'

      expect(page).to have_content('Motivo não pode ficar em branco')
      expect(page).to have_content('Valor precisa ser um número')
      expect(page).to have_content('Horas precisa ser um número')
      expect(page).not_to have_content('Proposta enviada com sucesso!')
    end

    it 'and fill correctly' do
      trabalhador = create(:professional, status_profile: 10)
      create(:profile, professional: trabalhador)
      create(:project)
      # Stub e Mok, stub é na preparação e mok é na expectativa.
      mailer_spy = class_spy(ProposalMailer) # cria espião para espionar o que acontece com a classe
      stub_const('ProposalMailer', mailer_spy) # coloca o espião no lugar da classe
      mail = double
      allow(ProposalMailer) # permite que a classe receba um metodo e tenha um retorno que eu defini.
        .to receive(:notify_new_proposal).and_return(mail)
      allow(mail).to receive(:deliver_now)

      login_as trabalhador, scope: :professional
      visit root_path
      click_on 'Projeto Marketplace'
      click_on 'Candidatar para projeto'
      fill_in 'Motivo:', with: 'Quero trabalhar'
      fill_in 'Valor/hora', with: '50'
      fill_in 'Horas disponíveis', with: '15'
      fill_in 'Expectativa', with: 'Adquirir conhecimento'
      click_on 'Enviar proposta'

      expect(ProposalMailer).to have_received(:notify_new_proposal)
      expect(mail).to have_received(:deliver_now)
      expect(page).to have_content('Proposta enviada com sucesso!')
      expect(page).to have_content('Valor/hora: R$ 50,00')
      expect(page).to have_content('Horas disponíveis: 15')
      expect(page).to have_content('Proposta enviada com sucesso!')
    end

    it 'and cancel proposal' do
      trabalhador = create(:professional, status_profile: 10)
      create(:profile, professional: trabalhador)
      contratador = create(:user)
      projeto = create(:project, user: contratador)
      create(:proposal, project: projeto, professional: trabalhador,
                        reason: 'Fazer um ótimo trabalho')

      login_as trabalhador, scope: :professional
      visit root_path
      click_on 'Minhas Propostas'
      click_on 'Ver Proposta'
      click_on 'Cancelar Proposta'

      expect(page).to have_content('Proposta cancelada com sucesso!')
    end

    it 'and tries to open another proposal for the same project' do
      trabalhador = create(:professional, status_profile: 10)
      create(:profile, professional: trabalhador)
      contratador = create(:user)
      projeto = create(:project, user: contratador)
      create(:proposal, project: projeto, professional: trabalhador,
                        reason: 'Fazer um ótimo trabalho')

      login_as trabalhador, scope: :professional
      visit root_path
      click_on 'Projeto Marketplace'
      click_on 'Candidatar para projeto'
      fill_in 'Motivo:', with: 'Quero trabalhar'
      fill_in 'Valor/hora', with: '110'
      fill_in 'Horas disponíveis', with: '25'
      fill_in 'Expectativa', with: 'Adquirir conhecimento'
      click_on 'Enviar proposta'

      expect(page).to have_content('Você já tem uma proposta para este projeto!')
    end

    it 'and tries to open another proposal for the same project' do
      trabalhador = create(:professional, status_profile: 10)
      create(:profile, professional: trabalhador)
      contratador = create(:user)
      projeto = create(:project, user: contratador)
      create(:proposal, project: projeto, professional: trabalhador,
                        reason: 'Fazer um ótimo trabalho')

      login_as trabalhador, scope: :professional
      visit root_path
      click_on 'Minhas Propostas'
      click_on 'Ver Proposta'
      click_on 'Editar Proposta'
      fill_in 'Motivo:', with: 'Quero trabalhar'
      fill_in 'Valor/hora', with: '110'
      fill_in 'Horas disponíveis', with: '25'
      fill_in 'Expectativa', with: 'Adquirir conhecimento'
      click_on 'Enviar proposta'

      expect(page).to have_content('Proposta editada com sucesso!')
    end
  end

  context 'User view proposal' do
    it 'and try make proposal' do
      contratador = create(:user)
      projeto = create(:project, user: contratador)

      login_as contratador, scope: :user
      visit root_path
      click_on projeto.title

      expect(page).not_to have_link('Candidatar para projeto')
    end
  end
end
