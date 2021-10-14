require 'rails_helper'

describe 'User register project' do 
    it 'successfuly' do 
        contratador = User.create!(email:'luiz@fernando.com', password:'123456')
        visit root_path
        click_on 'Entrar como contratador'
  
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Cadastrar Projeto'
        fill_in 'Título', with: 'Projeto inovador'
        fill_in 'Descrição', with: 'Realizaremos um projeto em ruby on rails'
        fill_in 'Habilidades', with: 'Ruby on rails, vontade de criar'
        select 'Remoto', from: 'Modalidade'
        fill_in 'Valor máximo pago por hora', with:'50'
        fill_in 'Data limite para candidatura', with:'13/12/2021'
        fill_in 'Inicio do projeto', with:'13/01/2022'
        fill_in 'Previsão de término', with:'13/02/2022'
        click_on 'Enviar'

        expect(page).to have_content('Projeto inovador')
        expect(page).to have_content('Descrição: Realizaremos um projeto em ruby on rails')
        expect(page).to have_content('Habilidades: Ruby on rails, vontade de criar')
        expect(current_path).to eq root_path
    end
end