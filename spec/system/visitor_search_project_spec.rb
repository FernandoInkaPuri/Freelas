require 'rails_helper'

describe 'Visitor search projects' do
  it 'successfuly' do
    contratador = create(:user)
    create(:project, user: contratador)
    create(:project, title: 'Projeto Cars',
                     description: 'Iremos programar um site para aluguel de carros', user: contratador)

    visit root_path

    find(:css, '.searchLabel').fill_in(with: 'carro')
    within 'form' do
      click_on 'Buscar'
    end

    expect(page).to have_content('Projeto Cars')
    expect(page).to have_content('Descrição: Iremos programar um site para aluguel de carros')
    expect(page).to have_content('Habilidade desejadas: Ruby on rails')
    expect(current_path).to eq search_projects_path
  end
end
