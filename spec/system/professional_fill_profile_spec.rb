require 'rails_helper'

describe 'Professional fill profile' do
  it 'successfuly' do
    trabalhador = create(:professional)
    visit root_path

    click_on 'Entrar como profissional'
  
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Meu perfil'
    fill_in 'Nome Completo', with: 'Luiz Fernando'
    fill_in 'Nome Social', with: 'Luiz Fernando'
    fill_in 'Data de Nascimento', with: '13/12/1998'
    fill_in 'Formação', with: 'Análise de sistemas'
    fill_in 'Descrição', with:'Sou um homem determinado e um ótimo profissional'
    fill_in 'Experiência', with:'2 anos como Dev Ruby'
    click_on 'Salvar'


    expect(page).to have_content('Luiz Fernando')
    expect(page).to have_content(trabalhador.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Análise de sistemas')
  end
end