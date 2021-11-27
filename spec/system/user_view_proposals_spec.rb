require 'rails_helper'

describe 'User view proposals' do
  it 'successfuly' do
    trabalhador1 = create(:professional)
    perfil1 = create(:profile, professional: trabalhador1)
    trabalhador2 = create(:professional)
    create(:profile, name: 'Tupac Amaru', social_name: 'Tupac Amaru',
                     professional: trabalhador2)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador1,
                      reason: 'Fazer um ótimo trabalho')
    create(:proposal, project: projeto, professional: trabalhador2,
                      reason: 'Fazer o melhor trabalho possível')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Projeto Marketplace'

    expect(page).to have_content(perfil1.social_name.to_s)
    expect(page).to have_content('Fazer um ótimo trabalho')
    expect(page).to have_content(perfil1.social_name.to_s)
    expect(page).to have_content('Fazer o melhor trabalho possível')
  end

  it 'and view profile of professional' do
    trabalhador1 = create(:professional)
    create(:profile, professional: trabalhador1)
    trabalhador2 = create(:professional)
    perfil2 = create(:profile, name: 'Tupac Amaru', social_name: 'Tupac Amaru',
                               professional: trabalhador2, birth_date: '14/04/1998')
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador1,
                      reason: 'Fazer um ótimo trabalho')
    create(:proposal, project: projeto, professional: trabalhador2,
                      reason: 'Fazer o melhor trabalho possível')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Projeto Marketplace'
    click_on 'Tupac Amaru'

    expect(page).to have_content(perfil2.social_name.to_s)
    expect(page).to have_content('14/04/1998')
    expect(page).to have_content(perfil2.formation.to_s)
    expect(page).to have_content(perfil2.description.to_s)
    expect(page).to have_content(perfil2.experience.to_s)
  end
  it 'and reject prposal' do
    trabalhador1 = create(:professional)
    create(:profile, professional: trabalhador1)
    create(:professional)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador1,
                      reason: 'Fazer um ótimo trabalho')

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Projeto Marketplace'
    click_on 'Rejeitar proposta'

    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Projeto top')
    expect(page).to have_content('Proposta rejeitada com sucesso!')
  end

  it 'and cancel a project' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
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
    click_on 'Projeto Marketplace'
    click_on 'Encerrar inscrições'
    click_on 'Logout'
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).not_to have_content('Projeto Marketplace')
    expect(page).not_to have_content('Projeto top')
    expect(page).not_to have_content('Ruby on rails')
    expect(page).not_to have_content(2.weeks.from_now.to_date.to_s)
  end

  it 'and view project team' do
    trabalhador1 = create(:professional)
    perfil1 = create(:profile, professional: trabalhador1)
    trabalhador2 = create(:professional)
    perfil2 = create(:profile, name: 'Tupac Amaru', social_name: 'Tupac Amaru',
                               professional: trabalhador2, birth_date: '14/04/1998')
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador1,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    create(:proposal, project: projeto, professional: trabalhador2,
                      reason: 'Fazer o melhor trabalho possível', status_proposal: 5)

    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Projeto Marketplace'
    click_on 'Time do Projeto'

    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content(perfil1.social_name.to_s)
    expect(page).to have_content(perfil1.formation.to_s)
    expect(page).to have_content(perfil2.social_name.to_s)
    expect(page).to have_content(perfil2.formation.to_s)
  end

  it 'and accept prposal' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
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
    click_on 'Projeto Marketplace'
    click_on 'Aceitar proposta'

    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Projeto top')
    expect(page).to have_content('Proposta aceita com sucesso!')
  end
end
