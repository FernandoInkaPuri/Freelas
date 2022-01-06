require 'rails_helper'

describe 'User register project' do
  it 'successfuly' do
    contratador = create(:user)
    login_as contratador, scope: :user
    visit root_path
    click_on 'Cadastrar Projeto'
    fill_in 'Título', with: 'Projeto inovador'
    fill_in 'Descrição', with: 'Realizaremos um projeto em ruby on rails'
    fill_in 'Habilidades desejadas', with: 'Ruby on rails, vontade de criar'
    select 'Remoto', from: 'Modalidade'
    fill_in 'Valor máximo pago por hora', with: '50'
    fill_in 'Data limite para candidatura', with: 2.weeks.from_now.to_date.to_s
    fill_in 'Inicio do projeto', with: 3.weeks.from_now.to_date.to_s
    fill_in 'Previsão de término', with: 2.months.from_now.to_date.to_s
    click_on 'Enviar'

    expect(page).to have_content('Projeto inovador')
    expect(page).to have_content('Descrição: Realizaremos um projeto em ruby on rails')
    expect(page).to have_content('Habilidades desejadas: Ruby on rails, vontade de criar')
    expect(current_path).to eq project_path(Project.last.id)
  end
end
