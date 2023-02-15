# Jets Project

### Registrar un nuevo token serverless gems
#### referencia
- https://blog.boltops.com/2021/01/07/introducing-serverless-gems/
- https://www.serverlessgems.com/tokens
- jets configure TOKEN

### setear ambiente en development para que use el env.development
- export JETS_ENV=local
- source ~/.zshrc

### Uso del JETS_ENV
- si JETS_ENV=local usara en tu maquina local el env.local
- si JETS_ENV=development usara en tu maquina local el env.development

### Para desplegar ambiente dev se usa JETS_ENV=development
- JETS_ENV=development AWS_PROFILE=develop jets deploy si tienes varios perfiles
- JETS_ENV=development jets deploy si solo tienes la por defecto

### si se produce el error "Could not find timeout-0.3.1 in any of the sources."
https://community.boltops.com/t/could-not-find-timeout-0-3-1-in-any-of-the-sources/996

### DB dynamoDB
- descargar la bd local https://docs.aws.amazon.com/es_es/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
- ir al directorio de descarga ejm cd /home/user/DynamoDB/dynamodb_local_latest
- correr en la terminal java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
- instalar el aws NoSQL Workbench https://docs.aws.amazon.com/es_es/amazondynamodb/latest/developerguide/workbench.settingup.html

### Crear las tablas
- jets c
- DynamoDb::Create.tables
- DynamoDb::Delete.tables