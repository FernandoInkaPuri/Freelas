require 'rails_helper'

describe 'User ends project' do 
    it 'succesfully' do 
        trabalhador = Professional.create!(email:'sandrão@rzo.com', password:'123456', status_profile:10)
        perfil = Profile.create!(name:'Sandro', social_name:'Sandro', 
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
                                      project: projeto, professional: trabalhador ) 

        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Sandro'
        click_on 'Marcar como favorito'

        expect(page).to have_content('Favorito!')
    end

end