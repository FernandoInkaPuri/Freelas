require 'rails_helper'

describe 'someone favorite brand' do
  it 'professional favorite contractor' do
    trabalhador = create(:professional, status_profile: 10)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)

    login_as trabalhador, scope: :professional
    visit root_path
    click_on projeto.title
    click_on 'Marcar'

    expect(page).to have_content('Contratador marcado como favorito')
  end

  it 'professional favorite contractor and desfavorite' do
    trabalhador = create(:professional, status_profile: 10)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)

    login_as trabalhador, scope: :professional
    visit root_path
    click_on projeto.title
    click_on 'Marcar'
    click_on 'Marcar'

    expect(page).not_to have_content('Contratador marcado como favorito')
  end

  it 'contractor favorite professional' do
    trabalhador = create(:professional, status_profile: 10)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 0)

    login_as contratador, scope: :user
    visit root_path
    click_on 'Meus Projetos'
    click_on projeto.title
    click_on trabalhador.profile.social_name
    click_on 'Marcar'

    expect(page).to have_content('Você marcou este profissional como Favorito!')
  end

  it 'contractor favorite professional and desfavorite' do
    trabalhador = create(:professional, status_profile: 10)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 0)

    login_as contratador, scope: :user
    visit root_path
    click_on 'Meus Projetos'
    click_on projeto.title
    click_on trabalhador.profile.social_name
    click_on 'Marcar'
    click_on 'Marcar'

    expect(page).not_to have_content('Você marcou este profissional como Favorito!')
  end
end
