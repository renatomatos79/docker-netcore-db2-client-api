Criando o servidor DB2:
docker run -itd --name mydb2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=myDB2@123 -e DBNAME=testdb -v C:\Temp\Data:/database ibmcom/db2

Dados da instancia:
DATABASE=testdb;
HOSTNAME=127.0.0.1;
PORT=50000;
UID=db2inst1;
PASSWORD=myDB2@123

Connection String local windows:
Server=127.0.0.1:50000;Database=testdb;UID=db2inst1;PWD=myDB2@123;

Inicializando a variavel de ambiente CONNECTION_STRING para rodar no windows:
set CONNECTION_STRING=U2VydmVyPTEyNy4wLjAuMTo1MDAwMDtEYXRhYmFzZT10ZXN0ZGI7VUlEPWRiMmluc3QxO1BXRD1teURCMkAxMjM7

Connection String para uso no docker usando mydb2:
Server=mydb2:50000;Database=testdb;UID=db2inst1;PWD=myDB2@123;

Connection String docker em base64:
U2VydmVyPW15ZGIyOjUwMDAwO0RhdGFiYXNlPXRlc3RkYjtVSUQ9ZGIyaW5zdDE7UFdEPW15REIyQDEyMzs=

URLs para teste do projeto:
Windows: http://localhost:5000/products
Docker: http://localhost:8001/products

Sequencia de comandos:
1) construir a imagem
docker build -t core-db2-api:3.1 .

2) remover o container anterior:
docker rm core_docker_db2_api --force

3) subir o container
docker run -d -p 8001:80 --name core_docker_db2_api --network=db-network -e CONNECTION_STRING=U2VydmVyPW15ZGIyOjUwMDAwO0RhdGFiYXNlPXRlc3RkYjtVSUQ9ZGIyaW5zdDE7UFdEPW15REIyQDEyMzs= -v c:\Temp:/tmp core-db2-api:3.1

4) consultar os logs
docker logs core_docker_db2_api

5) acessar o container
docker exec -ti core_docker_db2_api bash 


6) deixando os containers na mesma rede

docker network create --driver=bridge --subnet=172.29.0.0/16 --ip-range=172.29.5.0/24 db-network
docker network connect db-network mydb2
docker network connect core_docker_db2_api