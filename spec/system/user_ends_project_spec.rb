require 'rails_helper'

describe 'User ends project' do
  it 'succesfully' do
    trabalhador = create(:professional)
    perfil = create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on projeto.title.to_s
    click_on 'Encerrar Projeto'
    
    expect(page).to have_content('Projeto encerrado com sucesso!')
    expect(page).not_to have_content(projeto.title.to_s)
  end

  it 'and gives feedback' do
    trabalhador = create(:professional)
    perfil = create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on projeto.title.to_s
    click_on 'Aceitar proposta'
    click_on 'Encerrar Projeto'
    first(:label, 'Feedback').set('Ótimo desenvolvedor, gosta do que faz')
    first(:label, 'Nota').set('5')
    first(:css, 'form').click_on 'Enviar'

    expect(page).to have_content("Feedback de #{perfil.social_name} enviado com sucesso!")
    expect(page).not_to have_content('Projeto Marketplace')
  end

  it 'and gives feedback and view profile note' do
    trabalhador = create(:professional)
    perfil = create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on projeto.title.to_s
    click_on 'Aceitar proposta'
    click_on 'Encerrar Projeto'
    first(:label, 'Feedback').set('Ótimo desenvolvedor, gosta do que faz')
    first(:label, 'Nota').set('5')
    first(:css, 'form').click_on 'Enviar'
    visit profile_path(perfil)

    expect(page).to have_content('Nota: 5')
    expect(page).to have_content(perfil.social_name.to_s)
  end

  it 'and professional gives feedback' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    visit root_path
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Feedbacks'
    
    first(:label, 'Contratador').set('É um bom contratador')
    first(:label, 'Nota').set('5')
    first(:css, 'form').click_on 'Enviar'
    
    expect(page).to have_content("Feedback de #{contratador.email} enviado com sucesso!")
  end
end
