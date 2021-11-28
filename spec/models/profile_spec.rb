require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    subject { Profile.new }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:social_name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:birth_date).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:formation).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:experience).with_message('não pode ficar em branco') }
  end  
end
