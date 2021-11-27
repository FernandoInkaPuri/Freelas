require 'rails_helper'

describe 'User view your projects' do
  it 'successfuly' do
    chefe = create(:user)
    create(:project, user: chefe)
    visit root_path
    click_on 'Entrar como contratador'
    fill_in 'Email', with: chefe.email
    fill_in 'Senha', with: chefe.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Meus Projetos'

    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Projeto top')
  end
end
