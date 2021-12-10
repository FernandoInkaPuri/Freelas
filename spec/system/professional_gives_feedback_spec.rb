require 'rails_helper'

describe 'Professional gives feedback' do
  it 'to contractor' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    visit root_path
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Feedbacks'
  
    within '.contractorForm' do
      fill_in 'Feedback do Contratador:', with: 'Muito bom trabalhar com ele'
      fill_in 'Nota do Contratador:', with: '5'
      click_on 'Enviar'
    end

    expect(page).to have_content("Feedback de #{contratador.email} enviado com sucesso!")
  end

  it 'to contractor but fills wrong' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    visit root_path
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Feedbacks'
  
    within '.contractorForm' do
      fill_in 'Feedback do Contratador:', with: ''
      fill_in 'Nota do Contratador:', with: ''
      click_on 'Enviar'
    end
    
    expect(page).to have_content("Preencha os campos corretamente!")
  end

  it 'to project' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    visit root_path
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Feedbacks'
  
    within '.projectForm' do
      fill_in 'Feedback do Projeto:', with: 'Ótimo desenvolvedor, gosta do que faz'
      fill_in 'Nota do Projeto:', with: '5'
      click_on 'Enviar'
    end
    
    expect(page).to have_content("Feedback de Projeto Marketplace enviado com sucesso!")
  end

  it 'to project but fills wrong' do
    trabalhador = create(:professional)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho', status_proposal: 5)
    visit root_path
    click_on 'Entrar como profissional'
    fill_in 'Email', with: trabalhador.email
    fill_in 'Senha', with: trabalhador.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Feedbacks'
  
    within '.projectForm' do
      fill_in 'Feedback do Projeto:', with: ''
      fill_in 'Nota do Projeto:', with: ''
      click_on 'Enviar'
    end
    
    expect(page).to have_content("Preencha os campos corretamente!")
  end
end


