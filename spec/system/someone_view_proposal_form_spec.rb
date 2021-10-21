require 'rails_helper'

describe 'Someone view proposal form' do 
    context 'professional view proposal' do
        it 'and fills wrong ' do 
            trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
            perfil = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador )
            contratador = User.create!(email:'faustao@globo.com', password:'123456')
            projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                              skills:'Ruby on rails', max_value:'100', 
                              limit_date:'13/02/2025', start_date:'13/03/2025',
                              end_date: '13/04/2025', modality: 0, user: contratador)
            visit root_path

            click_on 'Entrar como profissional'
            
            fill_in 'Email', with: trabalhador.email
            fill_in 'Senha', with: trabalhador.password
            within 'form' do
            click_on 'Entrar'
            end

            click_on 'Projeto Marketplace'
            click_on 'Candidatar para projeto'
            fill_in 'Motivo:', with: ''
            fill_in 'Valor/hora', with: 'churrasco'
            fill_in 'Horas disponíveis', with: 'batata'
            fill_in 'Expectativa', with: ''  
        
            click_on 'Enviar proposta'
            expect(page).to have_content('Motivo não pode ficar em branco')
            expect(page).to have_content('Valor precisa ser um número')
            expect(page).to have_content('Horas precisa ser um número')
            expect(page).not_to have_content('Proposta enviada com sucesso!')
        end

        it 'and fill correctly' do 
            trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
            perfil = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador )
            contratador = User.create!(email:'fautao@globo.com', password:'123456')
            projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                              skills:'Ruby on rails', max_value:'100', 
                              limit_date:'13/02/2025', start_date:'13/03/2025',
                              end_date: '13/04/2025', modality: 0, user: contratador)
            visit root_path

            click_on 'Entrar como profissional'
  
            fill_in 'Email', with: trabalhador.email
            fill_in 'Senha', with: trabalhador.password
            within 'form' do
            click_on 'Entrar'
            end

            click_on 'Projeto Marketplace'
            click_on 'Candidatar para projeto'
            fill_in 'Motivo:', with: 'Quero trabalhar'
            fill_in 'Valor/hora', with: '50'
            fill_in 'Horas disponíveis', with: '15'
            fill_in 'Expectativa', with: 'Adquirir conhecimento'  
        
            click_on 'Enviar proposta'

            expect(page).to have_content('Proposta enviada com sucesso!')
            expect(page).to have_content('Valor/hora: R$ 50,00')
            expect(page).to have_content('Horas disponíveis: 15')
            expect(page).to have_content('Proposta enviada com sucesso!')
        end
    end

    context 'User view proposal' do 
        it 'and try make proposal' do

            contratador = User.create!(email:'luiz@fernando.com', password:'123456')
            projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                              skills:'Ruby on rails', max_value:'100', 
                              limit_date:'13/02/2025', start_date:'13/03/2025',
                              end_date: '13/04/2025', modality: 0, user: contratador)
            visit root_path
            click_on 'Entrar como contratador'
  
            fill_in 'Email', with: contratador.email
            fill_in 'Senha', with: contratador.password
            within 'form' do
                click_on 'Entrar'
            end
            click_on 'Projeto Marketplace'

            expect(page).not_to have_link('Candidatar para projeto')
    
        end
    end
end