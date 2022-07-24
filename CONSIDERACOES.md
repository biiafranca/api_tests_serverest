# Considerações do Projeto
Seguem algumas considerações sobre as escolhas feitas no projeto.

- A suite "users_functionality_test" analisa a estrutura de Requisições e Respostas do endpoint /usuarios, sendo que cada conjunto de Ação e Resultado esperado encontra-se em um único Test Case. Todos os recursos utilizados estão no diretório "resources".

- A suite "create_shopping_cart_flow_test" trata de um fluxo completo, que analisa variadas Requisições e Respostas, em também variados endpoints. 
Os recursos utilizados também estão no diretório "resources", porém, como cada passo de teste é mais abrangente que na suite anteriormente citada, 
o arquivo de testes contém na sessão "Keywords" o detalhamento das ações executadas. Uma escolha possível seria a criação de um arquivo de recursos 
para essas keywords, mantendo o padrão de separação entre arquivos de testes e de recursos, porém, neste caso específico, considerou-se que a organização em um mesmo arquivo facilitaria a compressão geral do teste.
