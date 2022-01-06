require 'rails_helper'

describe 'Professional view projects' do
  it 'successfuly' do
    trabalhador = create(:professional, status_profile: 10)
    projeto = create(:project, description: FFaker::LoremBR.paragraph)

    login_as trabalhador, scope: :professional
    visit root_path
    click_on projeto.title.to_s

    expect(page).to have_content(trabalhador.email)
    expect(page).to have_content(projeto.title.to_s)
    expect(page).to have_content(projeto.description)
    expect(page).to have_content('Habilidades desejadas: Ruby on rails')
    expect(page).to have_content('Valor max por hora: R$ 100,00')
    expect(page).to have_content("Data limite para candidatura: #{I18n.l 2.weeks.from_now.to_date}")
    expect(page).to have_content("Inicio do projeto: #{I18n.l 3.weeks.from_now.to_date}")
    expect(page).to have_content("Previsão de término: #{I18n.l 2.months.from_now.to_date}")
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
  end
  it 'and see all your proposals' do
    trabalhador = create(:professional, status_profile: 10)
    projeto = create(:project)
    proposta = create(:proposal, project: projeto, professional: trabalhador,
                                 reason: 'Fazer um ótimo trabalho')

    login_as trabalhador, scope: :professional
    visit root_path
    click_on 'Minhas Propostas'

    expect(page).to have_content(projeto.title.to_s)
    expect(page).to have_content("Motivo: #{proposta.reason}")
    expect(page).to have_content("Valor/hora: R$ #{proposta.hour_value.to_i},00")
    expect(page).to have_content('Status: Pendente')
  end

  it 'and sets user as favorite' do
    trabalhador = create(:professional, status_profile: 10)
    create(:profile, professional: trabalhador)
    contratador = create(:user)
    projeto = create(:project, user: contratador)
    create(:proposal, project: projeto, professional: trabalhador,
                      reason: 'Fazer um ótimo trabalho')

    login_as trabalhador, scope: :professional
    visit root_path
    click_on projeto.title.to_s
    click_on 'Marcar'

    expect(page).to have_content('Contratador marcado como favorito')
  end
end
