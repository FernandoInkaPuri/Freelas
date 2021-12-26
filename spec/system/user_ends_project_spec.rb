require 'rails_helper'

describe 'User ends project' do
  it 'succesfully' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    login_as contratador, scope: :user
    visit root_path
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

    login_as contratador, scope: :user
    visit root_path
    click_on projeto.title.to_s
    click_on 'Aceitar proposta'
    click_on 'Encerrar Projeto'
    fill_in 'Feedback:', with: 'Ótimo desenvolvedor, gosta do que faz'
    fill_in 'Nota:', with: '5'
    click_on 'Enviar'

    expect(page).to have_content("Feedback de #{perfil.social_name} enviado com sucesso!")
    expect(page).not_to have_content('Projeto Marketplace')
  end

  it 'and gives feedback but fills wrong' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    login_as contratador, scope: :user
    visit root_path
    click_on projeto.title.to_s
    click_on 'Aceitar proposta'
    click_on 'Encerrar Projeto'
    fill_in 'Feedback:', with: ''
    fill_in 'Nota:', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Preencha os campos corretamente!')
    expect(page).not_to have_content('Projeto Marketplace')
  end

  it 'and gives feedback and view profile note' do
    trabalhador = create(:professional)
    perfil = create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    login_as contratador, scope: :user
    visit root_path
    click_on projeto.title.to_s
    click_on 'Aceitar proposta'
    click_on 'Encerrar Projeto'
    fill_in 'Feedback:', with: 'Ótimo desenvolvedor, gosta do que faz'
    fill_in 'Nota:', with: '5'
    click_on 'Enviar'
    visit profile_path(perfil)

    expect(page).to have_content('Nota: 5')
    expect(page).to have_content(perfil.social_name.to_s)
  end
end
