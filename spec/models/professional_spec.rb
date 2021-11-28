require 'rails_helper'

RSpec.describe Professional, type: :model do
  describe 'validations' do
    subject { Professional.new }

    it { should validate_presence_of(:email).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:password).with_message('não pode ficar em branco') }
  end
end
