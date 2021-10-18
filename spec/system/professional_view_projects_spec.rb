require 'rails_helper'

describe 'Professional view projects' do
  it 'successfuly' do
    trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
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

    expect(page).to have_content(trabalhador.email)
    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Descrição: Projeto top')
    expect(page).to have_content('Habilidade desejadas: Ruby on rails')
    expect(page).to have_content('Valor max por hora: R$ 100,00')
    expect(page).to have_content('Data limite para candidatura: 13/02/2025')
    expect(page).to have_content('Inicio do projeto: 13/03/2025')
    expect(page).to have_content('Previsão de término: 13/04/2025')
    #expect(page).to have_content('Status do projeto: Aberto')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
  end
  it 'and see all your proposals' do 
    trabalhador = Professional.create!(email:'heliao@rzo.com', password:'123456', status_profile:10)
    contratador = User.create!(email:'fautao@globo.com', password:'123456')
    projeto = Project.create!(title: 'Projeto Marketplace', description:'Projeto top',
                              skills:'Ruby on rails', max_value:'100', 
                              limit_date:'13/02/2025', start_date:'13/03/2025',
                              end_date: '13/04/2025', modality: 0, user: contratador)
    proposta_1 = Proposal.create!(reason:'Trabalhar', hour_value:'50', hours_week:'15', 
                                  expectation:'trabalhar', status_proposal: 0, 
                                  project: projeto, professional: trabalhador)
    
    visit root_path

    click_on 'Entrar como profissional'
  
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Minhas Propostas'


    expect(page).to have_content('Projeto Marketplace')
    expect(page).to have_content('Motivo: Trabalhar')
    expect(page).to have_content('Valor/hora: R$ 50,00')
    expect(page).to have_content('Status: Pendente')
  end
end