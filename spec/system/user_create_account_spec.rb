require 'rails_helper'

describe 'User create account' do
  it 'successfuly' do
    contratador = User.create!(email:'luiz@fernando.com', password:'123456')
    visit root_path

    click_on 'Entrar como contratador'
  
    fill_in 'Email', with: contratador.email
    fill_in 'Senha', with: contratador.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).to have_content(contratador.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Cadastrar Projeto')
  end
end