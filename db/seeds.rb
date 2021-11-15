# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ganesha = User.create!(email: 'Ganesha@jay.com', password: '123456')
shiva = User.create!(email: 'Shiva@jay.com', password: '123456')
fernando = Professional.create!(email:'fernando@puri.com', password: '778899', status_profile:10)
guilherme = Professional.create!(email:'guilherme@tanan.com', password: '333777', status_profile:10)
perfil_1 = Profile.create!(name:'Luiz Fernando', social_name:'Luiz Fernando', 
                                   birth_date: '10/10/1998', formation:'Analises', 
                                   description: 'Quero trabalhar e me desenvolver. ', 
                                   experience:'2 anos dev ruby', professional: fernando )
perfil_2 = Profile.create!(name:'Guilherme Tanan', social_name:'Guilherme Tanan', 
                                   birth_date: '10/10/2000', formation:'Analises', 
                                   description: 'Quero trabalhar e me desenvolver. ', 
                                   experience:'2 anos dev ruby', professional: guilherme )                             
projeto_jaguar = Project.create!(title: 'Projeto Jaguar', description:'Iremos programar um site para quem gosta de trilhas',
                                   skills:'Ruby on rails', max_value:'80', 
                                   limit_date: "#{1.week.from_now.to_date}", start_date:"#{2.weeks.from_now.to_date}",
                                   end_date: "#{1.month.from_now.to_date}", modality: 0, user: ganesha)
projeto_yoga = Project.create!(title: 'Projeto Yoga', description:'Queremos criar um site para nossa escola de yoga',
                                   skills:'Ruby on rails', max_value:'100', 
                                   limit_date: "#{2.week.from_now.to_date}", start_date:"#{3.weeks.from_now.to_date}",
                                   end_date: "#{2.months.from_now.to_date}", modality: 0, user: shiva)                                   
proposta_1 = Proposal.create!(reason:'Gostei muito da ideia do projeto', hour_value:'100',
                                   hours_week:'10', expectation: 'Aprender mais e fazer um bom trabalho', 
                                   project: projeto_jaguar, professional: fernando)
proposta_2 = Proposal.create!(reason:'Me interessei muito pelo projeto', hour_value:'100',
                                   hours_week:'10', expectation: 'Desenvolver um bom código', 
                                   project: projeto_yoga, professional: fernando, status_proposal: 5)                                     
proposta_3 = Proposal.create!(reason:'Gostaria muito de participar deste projeto', hour_value:'100',
                                    hours_week:'10', expectation: 'Programar bastante', 
                                    project: projeto_yoga, professional: guilherme, status_proposal: 5)  