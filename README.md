# Desafio de Testes Funcionais - API
Testes de API no simulador ServeRest, utilizando Robot Framework

O Robot Framework é uma ferramenta de código aberto, voltada para automação de testes e processos. Ela utiliza uma abordagem keyword-driven, sendo de fácil aprendizagem, manutenção e interpretação. 

Também haverá a utilização das bibliotecas: RequestsLibrary, para envio de requisições para a API; FakerLibrary, para geração de dados aleatórios utilizados no teste; e Collections, para análise e manipulação dos dicionários de Requisição e/ou Resposta.

## Requisitos

A máquina poderá ter sistema operacional Linux ou Windows.

Deverão ser instaladas as seguintes ferramentas:

- Python 3
- Pip
- RobotFramework

## Instalação

### Python 3

##### Linux:
Para instalar o Python 3, digite no terminal:

    $ sudo apt-get install python3

##### Windows:
Para instalar o Python 3, acesse o link https://www.python.org/downloads/ e faça download da versão mais recente disponível.

Na primeira tela do assistente de instalação, não esqueça de marcar a opção "Add Python to PATH".

A instalação do Pip será realizada em conjunto.

Para cofirmar a instalação, abra o CMD e digite:

    python --version

### Pip

##### Linux:
Para instalar o Pip, o gerenciador de pacotes do Pyhton, digite no terminal:
	
	$ sudo apt-get install python3-pip

##### Windows:
O Pip já terá sido instalado juntamente com o Python.

Para confirmar a instalação, digite no CMD:
    
    pip --version

### RobotFramework

##### Linux e Windows:
Para instalar o RobotFramework:
	
	$ pip install robotframework
	
Para confirmar a instalação, feche e abra novamente o terminal, e digite o seguinte comando:

    $ robot --version

### Demais dependências
Instale as dependências necessárias:
    
    $ pip install -r requirements.txt

## Executando os testes

O Robot Framework possui a seguinte sintaxe:

Para executar todos os testes:
    
    $ robot diretorio/de/testes

Para definir os diretório onde os relatórios dos resultados serão armazenados, utilize o -d:

    $ robot -d ./diretorio/de/resultados diretorio/de/testes

OBS: Por boa prática, recomenda-se que o nome do diretório seja "results".

Para executar uma suíte de testes específicas:

    $ robot -d ./diretorio/de/resultados diretorio/de/testes/test_name.robot

Para executar um teste específico:

    $ robot -d ./diretorio/de/resultados -t "nome do teste" diretorio/de/testes/test_name.robot
