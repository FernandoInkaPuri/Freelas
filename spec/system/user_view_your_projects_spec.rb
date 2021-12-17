require 'rails_helper'

describe 'User view your projects' do
  it 'successfuly' do
    contratador = create(:user)
    create(:project, user: contratador)

    login_as contratador, scope: :user
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Projeto top')
  end
end
