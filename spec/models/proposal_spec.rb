require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'validations' do
    subject { Proposal.new }

    it { should validate_presence_of(:reason).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:hour_value).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:hours_week).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:expectation).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:status_proposal).with_message('não pode ficar em branco') }
    it { should validate_numericality_of(:hour_value).with_message('precisa ser um número') }
    it { should validate_numericality_of(:hours_week).with_message('precisa ser um número') }
  end  
end
