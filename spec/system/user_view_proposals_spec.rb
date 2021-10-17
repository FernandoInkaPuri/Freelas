require 'rails_helper'

describe 'User view proposals' do 
    it 'successfuly' do 
        trabalhador_1 = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
        perfil_1 = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador_1 )
        trabalhador_2 = Professional.create!(email:'tupac@amaru.com', password:'123456', status_profile:10)
        perfil_2 = Profile.create!(name:'Tupac', social_name:'Tupac Shakur', 
                                   birth_date: '10/10/1998', formation:'Ciencia da computação', 
                                   description: 'Eu sou um artista de codigo', 
                                   experience:'3 anos dev ruby', professional: trabalhador_2)
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
        projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                        skills:'Ruby on rails', max_value:'100', 
                        limit_date:'13/02/2025', start_date:'13/03/2025',
                        end_date: '13/04/2025', modality: 0, user: contratador)
        proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'60',
                                      hours_week:'10', expectation: 'Dinheirinhos', 
                                      project: projeto, professional: trabalhador_1) 
        proposta_2 = Proposal.create!(reason:'Fazer o melhor', hour_value:'99',
                                      hours_week:'10', expectation: 'Trabalhar bem', 
                                      project: projeto, professional: trabalhador_2)                               
        
        visit root_path
        click_on 'Entrar como contratador'
  
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'

        expect(page).to have_content('Helio Silva')
        expect(page).to have_content('Trabalhar')
        expect(page).to have_content('60')
        expect(page).to have_content('10')
        expect(page).to have_content('Dinheirinhos')
        expect(page).to have_content('Tupac Shakur')
        expect(page).to have_content('Fazer o melhor')
        expect(page).to have_content('99')
        expect(page).to have_content('10')
        expect(page).to have_content('Trabalhar bem')
    end

    it 'and view profile of professional' do 
        trabalhador_1 = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
        perfil_1 = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador_1 )
        trabalhador_2 = Professional.create!(email:'tupac@amaru.com', password:'123456', status_profile:10)
        perfil_2 = Profile.create!(name:'Tupac', social_name:'Tupac Shakur', 
                                   birth_date: '10/10/1998', formation:'Ciencia da computação', 
                                   description: 'Eu sou um artista de codigo', 
                                   experience:'3 anos dev ruby', professional: trabalhador_2)
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
        projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                        skills:'Ruby on rails', max_value:'100', 
                        limit_date:'13/02/2025', start_date:'13/03/2025',
                        end_date: '13/04/2025', modality: 0, user: contratador)
        proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'60',
                                      hours_week:'10', expectation: 'Dinheirinhos', 
                                      project: projeto, professional: trabalhador_1) 
        proposta_2 = Proposal.create!(reason:'Fazer o melhor', hour_value:'99',
                                      hours_week:'10', expectation: 'Trabalhar bem', 
                                      project: projeto, professional: trabalhador_2)                               
        
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Helio Silva'

        expect(page).to have_content('Helio Silva')
        expect(page).to have_content('10/10/1998')
        expect(page).to have_content('Analises')
        expect(page).to have_content('Sou um cara top, trampo muito')
        expect(page).to have_content('2 anos dev ruby')
    end
end