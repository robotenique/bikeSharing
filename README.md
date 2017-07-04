# Bikesharing

O projeto em questão se trata de uma aplicação de  bikesharing, e será desenvolvido usando Ruby on Rails. O principal objetivo deste projeto é facilitar a vida de pessoas que usam os pontos de empréstimo de bicicletas em São Paulo, O serviço que temos em mente se baseia em integrar dados de uso das estações em conjunto com geolocalização, para implementar funcionalidades diferenciadas.

Usaremos os dados da API do CityBikes, um projeto que disponibiliza vários dados de bikesharing. Com a API, podemos obter dados como: nome de estação, companhia que administra uma determinada estação, latitude e longitude, endereço e quantidade de bicicletas disponíveis e ocupadas de determinada estação. A API pode ser consultada em https://citybik.es/.

Em grupo, decidimos algumas funcionalidades que gostaríamos de desenvolver em cima deste projeto, sendo que elas possuem dois focos (que são interconectados): simplificar a vida de quem usa as estações, e fornecer estatísticas e informação relevante sobre bikesharing em São Paulo. A primeira delas é usar a API do Google Maps em conjunto com a do CityBikes: seria possível traçar rotas entre uma posição atual do usuário e alguma estação de bikesharing, tentando fazer o percurso utilizando as estações que possuem bicicletas disponíveis.

Em conjunto com a funcionalidade anterior, a aplicação terá que usar geolocalização para obter a posição atual do usuário, e então encontrar estações ao redor dele que possuam bicicletas. Além disso, também seria interessante fazer o contrário: encontrar estações próximas que tenham slots vazios para guardar a bicicleta.

Pretendemos também permitir que o usuário possa definir algumas estações como 'favoritas', com o intuito de simplificar a consulta de informações das estações mais utilizadas pelo usuário. Inicialmente, essa funcionalidade estaria ligada a uma conta de usuário.

Usando a API do CityBikes, também é possível obter informações que podem ser bastante úteis. Salvando os dados continuamente em um banco de dados, podemos criar estatísticas sobre a utilização dos pontos na cidade. Pode-se dividir São Paulo em regiões, e usando os dados salvos criar mapas informativos usando as estatísticas de uso diário, semanal, mensal, etc.

Além disso, uma seção onde há um ranking com as estações de maior e menor utilização facilitaria a análise sobre quais locais precisam de mais estações de bikesharing, ou quais estações estão sendo pouco utilizadas. E para a criação deste gráfico, iremos criar uma outra funcionalidade mais específica que seria exibir gráficos semanais para cada estação: Quantidade de bicicletas livres x em uso x dia da semana; Assim, um usuário teria ideia de como é a distribuição de uma determinada estação pela semana,  tendo recursos para planejar melhor seus percursos.

Ao integrar as funcionalidades da captura de dados com a geolocalização, esperamos criar uma aplicação que simplifique a vida do usuário, ao mesmo tempo que também permita obter informações mais detalhadas sobre a situação dos aplicativos de bikesharing na cidade de São Paulo!



## Authors

* **Duílio Elias** - [DuilioElias](https://github.com/duilioelias)
* **Juliano Garcia de Oliveira** - [robotenique](https://gitlab.com/robotenique)
* **Claudio Silva** - [ClaudioSilva](https://gitlab.com/ddkclaudio)
* **Caio Carmo** - [bcarmo-caio](https://gitlab.com/bcarmo-caio)
* **Bruno Scholl** - [brunobbs](https://gitlab.com/brunobbs)
* **Vitor Santos** - [Varyag](https://gitlab.com/Varyag)



## Usuário padrão
*E-mail : teste@teste.com*
*Senha  : 123456*

## Executar o projeto
Basta ir na pasta *bikesharingSP/BikeSharing*, executar *bundle install* pelo terminal para instalar as gems.
Em seguida, fazer o migrate do banco de dados, e rodar com *rails s*.

A lista completa das dependências pode ser vista no *.gemfile* dentro da pasta.


## Versão live (heroku)
As versões enviadas podem ser vistas no [heroku][https://immense-dawn-86994.herokuapp.com/] ! :D


## Telas (mockup)









Alguns prints das telas que pretendemos desenvolver:

Página Inicial:

![alt text](https://linux.ime.usp.br/~duilioelias/home.png)

Menu do lado esquerdo:

![alt text](https://linux.ime.usp.br/~duilioelias/leftMenu.png)

Menu do lado direito:

![alt text](https://linux.ime.usp.br/~duilioelias/leftMenu.png)

Tela de Login:

![alt text](https://linux.ime.usp.br/~duilioelias/login.png)

Rank das estações mais utilizadas:

![alt text](https://linux.ime.usp.br/~duilioelias/rank.png)

Estatísticas de cada estação:

![alt text](https://linux.ime.usp.br/~duilioelias/stats.png)

Para ver todas as telas acesse: https://ninjamock.com/s/LQ98L

Diagrama de classes:

![alt text](https://linux.ime.usp.br/~duilioelias/CitiBikes.png)


Para acompanhar o desenvolvimento do projeto estamos utilizando o trello:

[Trello BikeSharing](https://trello.com/bikesharingsp)
