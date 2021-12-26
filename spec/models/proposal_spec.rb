require 'rails_helper'

RSpec.describe Proposal, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  it 'code must be uniq' do
    proposal = create(:proposal)
    allow(SecureRandom).to receive(:alphanumeric).and_return(proposal.code, 'ARPA1212')
    other_proposal = create(:proposal)

    expect(other_proposal).to be_valid
    expect(other_proposal.code).to eq('ARPA1212')
  end
  describe 'validations' do
    subject { Proposal.new }

    it { should validate_presence_of(:reason).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:hour_value).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:hours_week).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:expectation).with_message('não pode ficar em branco') }
    it { should validate_numericality_of(:hour_value).with_message('precisa ser um número') }
    it { should validate_numericality_of(:hours_week).with_message('precisa ser um número') }
  end
end
