require 'rails_helper'

describe 'User ends project' do 
    it 'succesfully' do 
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
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
        click_on 'Encerrar Projeto'

        expect(page).to have_content('Projeto encerrado com sucesso!')
        expect(page).not_to have_content('Projeto Marketplace')
    end

    it 'and gives feedback' do 
        trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
        perfil = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador )
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
        projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                        skills:'Ruby on rails', max_value:'100', 
                        limit_date:'13/02/2025', start_date:'13/03/2025',
                        end_date: '13/04/2025', modality: 0, user: contratador)
        proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'60',
                                      hours_week:'10', expectation: 'Dinheirinhos', 
                                      project: projeto, professional: trabalhador) 

        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Aceitar proposta'
        click_on 'Encerrar Projeto'
        fill_in 'Feedback', with: 'Ótimo desenvolvedor, gosta do que faz'
        click_on 'Enviar'   

        #expect(page).to have_content('Projeto encerrado com sucesso!')
        expect(page).to have_content('Feedback de Helio Silva enviado com sucesso!')
        expect(page).not_to have_content('Projeto Marketplace')
    end

    it 'and gives feedback and view profile note' do 
        trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
        perfil = Profile.create!(name:'Helio', social_name:'Helio Silva', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador )
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
        projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                        skills:'Ruby on rails', max_value:'100', 
                        limit_date:'13/02/2025', start_date:'13/03/2025',
                        end_date: '13/04/2025', modality: 0, user: contratador)
        proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'60',
                                      hours_week:'10', expectation: 'Dinheirinhos', 
                                      project: projeto, professional: trabalhador) 

        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Aceitar proposta'
        click_on 'Encerrar Projeto'
        fill_in 'Feedback', with: 'Ótimo desenvolvedor, gosta do que faz'
        fill_in 'Nota', with: '5'
        click_on 'Enviar'  
        visit profile_path(perfil)

        #expect(page).to have_content('Projeto encerrado com sucesso!')
        expect(page).to have_content('Nota: 5')
        expect(page).to have_content('Helio Silva')
    end

    it 'and professional gives feedback' do 
        trabalhador_2 = Professional.create!(email:'sandrão@rzo.com', password:'123456', status_profile:10)
        perfil = Profile.create!(name:'Sandro', social_name:'Sandro', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Sou um cara top, trampo muito', 
                                   experience:'2 anos dev ruby', professional: trabalhador_2 )
        contratador = User.create!(email:'Amy@whinehouse.com', password:'123456')
        projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                        skills:'Ruby on rails', max_value:'100', 
                        limit_date:'13/02/2025', start_date:'13/03/2025',
                        end_date: '13/04/2025', modality: 0, user: contratador)
        proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'60',
                                      hours_week:'10', expectation: 'Dinheirinhos', 
                                      project: projeto, professional: trabalhador_2) 
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Aceitar proposta' 
        click_on 'Logout'
        click_on 'Entrar como profissional'
        fill_in 'Email', with: trabalhador_2.email
        fill_in 'Senha', with: trabalhador_2.password
        within 'form' do
            click_on 'Entrar'
        end
        visit root_path
        click_on 'Feedbacks'
        
        fill_in 'Contratador:', with: 'É um bom contratador' 
        fill_in 'Nota', with: '5'
        
        click_on 'Enviar'

        expect(page).to have_content('Feedback enviado com sucesso!')
    end
end