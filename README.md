# dart_postgres_wrapper
A simple postgres database wrapper. Makes it easy to use postgres requests.
### Available methods
- createConnection
- createTable
- drop
- copy
- replace
- setPrimaryKey
- setColType
- select
- insert
- deleteAll
### Example
```
import 'package:dart_postgres_wrapper/dart_postgres_wrapper.dart';
import 'package:dart_postgres_wrapper/data_type.dart';

main(List<String> arguments) async {
  String host = 'localhost';
  int port = 5432;
  String db = 'test';
  String dbUser = 'dbUser';
  String dbPassword = 'Password';
  String tab = 'tab';
  var pg = new PG(host, port, db, dbUser, dbPassword, tab);
  
  await pg.createConnection();
  
  await pg.createTable([
    new FieldAndType('nomenklatura', 'text'),
    new FieldAndType('magazin', 'text'),
    new FieldAndType('summaProdazhTyisRub', 'text'),
    new FieldAndType('natsenkaTyisRub', 'text'),
    new FieldAndType('natsenkaProc', 'text'),
  ]);

  await pg.copy('/opt/DataToImport2.csv', isCsv: true);

  await pg.replace('natsenkaProc', ',', '.');
  await pg.replace('natsenkaTyisRub', ',', '.');
  await pg.replace('summaProdazhTyisRub', ',', '.');

  await pg.setPrimaryKey();
  
  await pg.setColType('natsenkaProc', 'double precision');
  await pg.setColType('natsenkaTyisRub', 'double precision');
  await pg.setColType('summaProdazhTyisRub', 'double precision');

  print(await pg.select(whereIdFrom: 1, whereIdTo: 5));
  
  pg.drop();
}
```