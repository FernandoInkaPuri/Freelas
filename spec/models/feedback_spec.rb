require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'validations' do
    subject { Feedback.new }

    it { should validate_presence_of(:opinion).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:nota).with_message('não pode ficar em branco') }
  end
end
