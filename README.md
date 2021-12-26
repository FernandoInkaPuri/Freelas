<h1 align="center"> Freelas </h1>
<p align="justify"> O projeto é uma plataforma para profissionais freelancer e contratadores, desenvolvido com base nas aulas do programa Treinadev, da Campus Code.
</p>
<img src="https://img.shields.io/static/v1?label=rails&message=framework&color=red&style=for-the-badge&logo=rubyonrails"/>

## Funcionalidades
- Contratador e Profissional podem criar uma conta
- Contratador pode cadastra um projeto
- Profissional pode completar seu perfil com suas informações profissionais.
- É possível buscar projetos com a caixa de pesquisa
- Profissional pode fazer uma proposta para atuar em um projeto, e pode cancelar a proposta.
- Contratador vê as propostas e pode aceitar ou recusar
- Contratador pode dar feedback sobre o trabalho do profissional
- Profissional pode dar feedback sobre o projeto e o contratante do projeto em que participou.
- Contratador pode marcar profissionais favoritos
- Profissional pode marcar usuários favoritos
- Contratador pode encerrar um projeto
> Status do Projeto: Em desenvolvimento :gear: :wrench:

## Pré-Requisitos
- [Ruby](https://www.ruby-lang.org/): versão 3.0.0 
- [Rails](https://rubyonrails.org/): versão 6.1.4 
- [Node](https://nodejs.org/): versão 14.17.6
- [Yarn](https://rubyonrails.org/): versão 1.22.11 

## Como rodar a aplicação

#### No terminal, clone o projeto: 
> git clone https://github.com/FernandoInkaPuri/Freelas.git
#### Entre na pasta do projeto:
> cd Freelas
#### Instale as dependências 
> bin/setup
#### Crie o banco de dados
> rails db:migrate
#### Inicialize o banco de dados
> rails db:seed
#### Execute a aplicação 
> rails server

Pronto, agora é possível acessar a aplicação através da rota http://localhost:3000/ 

## Como rodar os testes
> $ rspec

## Linguagens e libs utilizadas :books:
- [Ruby](https://www.ruby-lang.org/) 
- [Rails](https://rubyonrails.org/) 
Framework para layouts prontos:
- [Bootstrap](https://getbootstrap.com/) 

### Usuários: 
|email|password|type|
| -------- | -------- | -------- |
|ganesha@jay.com |123456|Contratador|
|shiva@jay.com |123456|Contratador|
|fernando@puri.com |778899|Profissional|
|guilherme@tanan.com |333777|Profissional|