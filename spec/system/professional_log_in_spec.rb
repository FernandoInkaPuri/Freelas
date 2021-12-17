require 'rails_helper'

describe 'Professional login' do
  it 'successfuly' do
    trabalhador = create(:professional)

    login_as trabalhador, scope: :professional
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content(trabalhador.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
  end
end
