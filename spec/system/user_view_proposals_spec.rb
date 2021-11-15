require 'rails_helper'

describe 'User view proposals' do 
    it 'successfuly' do 
        trabalhador_1 = create(:professional)
        perfil_1 = create(:profile, professional: trabalhador_1)
        trabalhador_2 = create(:professional)
        perfil_2 = create(:profile, name:'Tupac Amaru', social_name: 'Tupac Amaru',
                          professional: trabalhador_2)
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta_1 = create(:proposal, project: projeto, professional: trabalhador_1,
                            reason: 'Fazer um ótimo trabalho')
        proposta_2 = create(:proposal, project: projeto, professional: trabalhador_2, 
                            reason: 'Fazer o melhor trabalho possível')                             

        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'

        expect(page).to have_content("#{perfil_1.social_name}")
        expect(page).to have_content('Fazer um ótimo trabalho')
        expect(page).to have_content("#{perfil_2.social_name}")
        expect(page).to have_content('Fazer o melhor trabalho possível')
    end

    it 'and view profile of professional' do 
        trabalhador_1 = create(:professional)
        perfil_1 = create(:profile, professional: trabalhador_1)
        trabalhador_2 = create(:professional)
        perfil_2 = create(:profile, name:'Tupac Amaru', social_name: 'Tupac Amaru',
                          professional: trabalhador_2, birth_date: '14/04/1998')
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta_1 = create(:proposal, project: projeto, professional: trabalhador_1,
                            reason: 'Fazer um ótimo trabalho')
        proposta_2 = create(:proposal, project: projeto, professional: trabalhador_2, 
                            reason: 'Fazer o melhor trabalho possível')                             
        
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Tupac Amaru'

        expect(page).to have_content("#{perfil_2.social_name}")
        expect(page).to have_content('14/04/1998')
        expect(page).to have_content("#{perfil_2.formation}")
        expect(page).to have_content("#{perfil_2.description}")
        expect(page).to have_content("#{perfil_2.experience}")
    end
    it 'and reject prposal' do 
        trabalhador_1 = create(:professional)
        perfil_1 = create(:profile, professional: trabalhador_1)
        trabalhador_2 = create(:professional)
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta_1 = create(:proposal, project: projeto, professional: trabalhador_1,
                            reason: 'Fazer um ótimo trabalho')                            
        
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Rejeitar proposta'

        expect(page).to have_content('Projeto Marketplace')
        expect(page).to have_content('Projeto top')
        expect(page).to have_content('Proposta rejeitada com sucesso!')
    end

    it 'and cancel a project' do 
        trabalhador = create(:professional)
        perfil = create(:profile, professional: trabalhador)
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta = create(:proposal, project: projeto, professional: trabalhador,
                            reason: 'Fazer um ótimo trabalho')                   
        
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Encerrar inscrições'
        click_on 'Logout'
        click_on 'Entrar como profissional'
        fill_in 'Email', with: trabalhador.email
        fill_in 'Senha', with: trabalhador.password
        within 'form' do
            click_on 'Entrar'
        end

        expect(page).not_to have_content('Projeto Marketplace')
        expect(page).not_to have_content('Projeto top')
        expect(page).not_to have_content('Ruby on rails')
        expect(page).not_to have_content("#{2.week.from_now.to_date}")
    end

    it 'and view project team' do 
        trabalhador_1 = create(:professional)
        perfil_1 = create(:profile, professional: trabalhador_1)
        trabalhador_2 = create(:professional)
        perfil_2 = create(:profile, name:'Tupac Amaru', social_name: 'Tupac Amaru',
                          professional: trabalhador_2, birth_date: '14/04/1998')
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta_1 = create(:proposal, project: projeto, professional: trabalhador_1,
                            reason: 'Fazer um ótimo trabalho', status_proposal: 5)
        proposta_2 = create(:proposal, project: projeto, professional: trabalhador_2, 
                            reason: 'Fazer o melhor trabalho possível', status_proposal: 5)

        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Time do Projeto'

        expect(page).to have_content('Projeto Marketplace')
        expect(page).to have_content("#{perfil_1.social_name}")
        expect(page).to have_content("#{perfil_1.formation}")
        expect(page).to have_content("#{perfil_2.social_name}")
        expect(page).to have_content("#{perfil_2.formation}")
    end

    it 'and accept prposal' do 
        trabalhador = create(:professional)
        perfil = create(:profile, professional: trabalhador)
        contratador = create(:user) 
        projeto = create(:project, user: contratador)                  
        proposta = create(:proposal, project: projeto, professional: trabalhador,
                            reason: 'Fazer um ótimo trabalho')                        
        
        visit root_path
        click_on 'Entrar como contratador'
        fill_in 'Email', with: contratador.email
        fill_in 'Senha', with: contratador.password
        within 'form' do
            click_on 'Entrar'
        end
        click_on 'Projeto Marketplace'
        click_on 'Aceitar proposta'

        expect(page).to have_content('Projeto Marketplace')
        expect(page).to have_content('Projeto top')
        expect(page).to have_content('Proposta aceita com sucesso!')
    end
end