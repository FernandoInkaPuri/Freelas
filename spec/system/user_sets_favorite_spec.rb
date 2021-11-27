require 'rails_helper'

describe 'User sets favorite' do
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
    click_on 'Projeto Marketplace'
    click_on perfil.social_name.to_s
    click_on 'Marcar como favorito'

    expect(page).to have_content('Favorito!')
  end
end
