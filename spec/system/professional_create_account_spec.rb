require 'rails_helper'

describe 'Professional create account' do
  it 'successfuly' do
    trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456')
    visit root_path

    click_on 'Entrar como profissional'
  
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).to have_content(trabalhador.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Procurar projeto')
  end
end