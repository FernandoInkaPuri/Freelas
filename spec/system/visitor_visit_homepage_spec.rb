require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path
    
    expect(current_path).to eq root_path
  end
end
