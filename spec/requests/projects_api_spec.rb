require 'rails_helper'

describe 'Project API' do
  context 'GET /api/v1/projects' do
    it 'should get projects' do
      project = create(:project, title: 'Projeto Vinícola Apolo')
      project2 = create(:project, title: 'Projeto Tempero da vó')

      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      expect(parsed_body.first[:title]).to eq('Projeto Vinícola Apolo')
      expect(parsed_body.second[:title]).to eq('Projeto Tempero da vó')
      expect(parsed_body.count).to eq(2)
    end

    it 'returns no projects' do
      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      expect(parsed_body).to be_empty
    end
  end
  context 'GET /api/v1/projects/:id' do
    it 'should return a project' do
      project = create(:project, title: 'Projeto Vinícola Apolo',
                                 description: 'Vamos criar uma plataforma de assinatura de vinhos',
                                 skills: 'Conhecimento em Ruby on Rails e bom raciocínio',
                                 max_value: 70)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq('Projeto Vinícola Apolo')
      expect(parsed_body[:description]).to eq('Vamos criar uma plataforma de assinatura de vinhos')
      expect(parsed_body[:skills]).to eq('Conhecimento em Ruby on Rails e bom raciocínio')
      expect(parsed_body[:max_value]).to eq('70.0')
    end

    it 'should return 404 if project does not exist' do
      get '/api/v1/projects/1111'

      expect(response).to have_http_status(404)
    end

    it 'should return 500 if database is not available' do
      project = create(:project, title: 'Projeto Vinícola Apolo',
                                 description: 'Vamos criar uma plataforma de assinatura de vinhos',
                                 skills: 'Conhecimento em Ruby on Rails e bom raciocínio',
                                 max_value: 70)
      allow(Project).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get '/api/v1/projects/1111'

      expect(response).to have_http_status(500)
    end
  end
  context 'POST /api/v1/projects' do
    it 'should save a new project' do
      contractor = create(:user)
      project_params = { project: { title: 'Site Horti-fruti Saúde',
                                    description: 'Queremos criar um site para nossa rede de lojas',
                                    skills: 'Conhecimento em Ruby on Rails',
                                    max_value: 111,
                                    limit_date: 1.week.from_now.to_date, start_date: 2.weeks.from_now.to_date,
                                    end_date: 2.months.from_now.to_date, modality: 0,
                                    user_id: contractor.id } }

      post '/api/v1/projects', params: project_params

      expect(response).to have_http_status(201)
      expect(parsed_body[:id]).to eq(Project.last.id)
      expect(parsed_body[:title]).to eq('Site Horti-fruti Saúde')
      expect(parsed_body[:description]).to eq('Queremos criar um site para nossa rede de lojas')
      expect(parsed_body[:skills]).to eq('Conhecimento em Ruby on Rails')
      expect(parsed_body[:max_value]).to eq('111.0')
      expect(parsed_body[:limit_date]).to eq(Date.parse(I18n.l(1.week.from_now.to_date)).to_s)
      expect(parsed_body[:start_date]).to eq(Date.parse(I18n.l(2.weeks.from_now.to_date)).to_s)
      expect(parsed_body[:end_date]).to eq(Date.parse(I18n.l(2.months.from_now.to_date)).to_s)
      expect(parsed_body[:modality]).to eq(0)
    end
  end
end
