require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new }

    it { should validate_presence_of(:email).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:password).with_message('não pode ficar em branco') }
  end
end
