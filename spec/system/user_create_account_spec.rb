require 'rails_helper'

describe 'User create account' do
  it 'successfuly' do
    visit root_path
    click_on 'Acesso'
    click_on 'Entrar como contratador'
    click_on 'Cadastre-se'
    fill_in 'Email', with: 'manco@capac.com'
    fill_in 'Senha', with: '999abc'
    fill_in 'Confirme a senha', with: '999abc'
    click_on 'Cadastrar'

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
    click_on 'Entrar'

    expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).to have_content(contratador.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Cadastrar Projeto')
  end
end
