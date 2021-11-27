require 'rails_helper'

describe 'Visit search projects' do
  it 'successfuly' do
    chefe = create(:user)
    create(:project, user: chefe)
    create(:project, title: 'Projeto Cars',
                     description: 'Iremos programar um site para aluguel de carros', user: chefe)

    visit root_path

    fill_in 'Pesquisar projeto:', with: 'carro'
    within 'form' do
      click_on 'Buscar'
    end

    expect(page).to have_content('Projeto Cars')
    expect(page).to have_content('Descrição: Iremos programar um site para aluguel de carros')
    expect(page).to have_content('Habilidade desejadas: Ruby on rails')
    expect(current_path).to eq search_projects_path
  end
end
