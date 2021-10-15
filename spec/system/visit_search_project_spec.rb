require 'rails_helper'

describe 'Visit search projects' do
    it 'successfuly' do
      chefe = User.create!(email:"shiva@jay.com", password:"333888")
      projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                                  skills:'Ruby on rails', max_value:'100', 
                                  limit_date:'13/02/2025', start_date:'13/03/2025',
                                  end_date: '13/04/2025', modality: 0, user: chefe)
      projeto_2 = Project.create!(title:"Projeto Cars", 
                                  description: "Iremos programar um site para aluguel de carros",
                                  skills: "Ruby on rails", modality:1, max_value:'50', 
                                  limit_date:"13/02/2025", start_date: "13/03/2025", 
                                  end_date: "13/04/2025", user: chefe )
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