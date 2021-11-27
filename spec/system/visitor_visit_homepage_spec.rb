require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Freelas')
    expect(page).to have_css('h3', text: 'A melhor plataforma freelancer do Brasil')
    expect(current_path).to eq root_path
  end
end
