require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    subject { Project.new }

    it { should validate_presence_of(:title).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:skills).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:max_value).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:limit_date).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:start_date).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:end_date).with_message('não pode ficar em branco') }
  end
end
