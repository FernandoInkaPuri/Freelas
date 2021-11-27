require 'rails_helper'

describe 'User create account' do
  it 'successfuly' do
    visit root_path
    click_on 'Entrar como contratador'
    click_on 'Sign up'

    fill_in 'Email', with: 'manco@capac.com'
    fill_in 'Senha', with: '999abc'
    fill_in 'Confirme a senha', with: '999abc'
    within 'form' do
      click_on 'Criar'
    end

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('manco@capac.com')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Cadastrar Projeto')
  end

  it 'and login' do
    contratador = create(:user)
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
