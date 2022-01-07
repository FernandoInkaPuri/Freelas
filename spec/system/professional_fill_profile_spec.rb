require 'rails_helper'

describe 'Professional fill profile' do
  context 'fill profile' do
    it 'successfully' do
      trabalhador = create(:professional)

      login_as trabalhador, scope: :professional
      visit root_path

      click_on 'Meu perfil'
      fill_in 'Nome Completo', with: 'Luiz Fernando'
      fill_in 'Nome Social', with: 'Luiz Fernando'
      fill_in 'Data de Nascimento', with: '13/12/1998'
      fill_in 'Formação', with: 'Análise de sistemas'
      fill_in 'Descrição', with: 'Sou um homem determinado e um ótimo profissional'
      fill_in 'Experiência', with: '2 anos como Dev Ruby'
      click_on 'Salvar'

      expect(page).to have_content('Luiz Fernando')
      expect(page).to have_content(trabalhador.email)
      expect(page).to have_link('Logout')
      expect(page).not_to have_link('Entrar')
      expect(page).to have_content('Análise de sistemas')
    end

    it 'but fills wrong' do 
      trabalhador = create(:professional)

      login_as trabalhador, scope: :professional
      visit root_path

      click_on 'Meu perfil'
      fill_in 'Nome Completo', with: ''
      fill_in 'Nome Social', with: ''
      fill_in 'Data de Nascimento', with: ''
      fill_in 'Formação', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Experiência', with: ''
      click_on 'Salvar'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Nome Social não pode ficar em branco')
      expect(page).to have_content('Data de Nascimento não pode ficar em branco')
      expect(page).to have_content('Formação não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Experiência não pode ficar em branco')
    end
  end

  context 'edit profile' do
    it 'successfully' do 
      trabalhador = create(:professional, status_profile:10)
      perfil = create(:profile, professional:trabalhador)

      login_as trabalhador, scope: :professional
      visit root_path
      click_on 'Meu perfil'
      click_on 'Editar Perfil'
      fill_in 'Experiência', with: '3 anos como Dev Ruby'
      click_on 'Salvar'

      expect(page).to have_content('Perfil editado com sucesso!')
    end
  end
end
