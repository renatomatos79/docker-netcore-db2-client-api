docker run -itd --name mydb2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=myDB2@123 -e DBNAME=testdb -v C:\Temp\Data:/database ibmcom/db2

data@Studio@123

DATABASE=testdb;
HOSTNAME=127.0.0.1;
PORT=50000;
UID=db2inst1;
PASSWORD=myDB2@123

Server=127.0.0.1:50000;Database=testdb;UID=db2inst1;PWD=myDB2@123;


codificar em base64:
Server=mydb2:50000;Database=testdb;UID=db2inst1;PWD=myDB2@123;

resultado:
U2VydmVyPW15ZGIyOjUwMDAwO0RhdGFiYXNlPXRlc3RkYjtVSUQ9ZGIyaW5zdDE7UFdEPW15REIyQDEyMzs=

container connection string:
set CONNECTION_STRING=U2VydmVyPTEyNy4wLjAuMTo1MDAwMDtEYXRhYmFzZT10ZXN0ZGI7VUlEPWRiMmluc3QxO1BXRD1teURCMkAxMjM7

windows connection string:


http://localhost:5000/products
http://localhost:8001/products

docker build -t core-db2-api:3.1 .
docker rm core_docker_db2_api --force
docker run -d -p 8001:80 --name core_docker_db2_api -e CONNECTION_STRING=U2VydmVyPW15ZGIyOjUwMDAwO0RhdGFiYXNlPXRlc3RkYjtVSUQ9ZGIyaW5zdDE7UFdEPW15REIyQDEyMzs= -v c:\Temp:/tmp core-db2-api:3.1
docker logs core_docker_db2_api

docker exec -ti core_docker_db2_api bash 


https://community.ibm.com/community/user/hybriddatamanagement/blogs/vishwa-hs1/2021/12/01/deploying-db2-net-core-app-on-redhat-openshift

docker network create --driver=bridge --subnet=172.29.0.0/16 --ip-range=172.29.5.0/24 db-network

docker network connect db-network mydb2
docker network connect core_docker_db2_api