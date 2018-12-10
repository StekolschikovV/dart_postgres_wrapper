import 'package:dart_postgres_wrapper/dart_postgres_wrapper.dart';
import 'package:dart_postgres_wrapper/data_type.dart';

main(List<String> arguments) async {
  String host = 'localhost';
  int pgPort = 5432;
  String db = 'infovizion';
  String dbUser = 'postgres';
  String dbPassword = 'newPassword';
  String tab = 'datatoimport';
  int from = 0;
  int to = 1;

  PG pg = new PG(host, pgPort, db, dbUser, dbPassword, tab);
  await pg.createConnection();

//  print(await pg.select(whereIdTo: 2, whereIdFrom: 1,where: true));
//  print(await pg.getTabInfo());

//  print(await pg.groupBy(['magazin'], sum: ['summaprodazhtyisrub', 'natsenkatyisrub'], where: true, whereIdFrom: 1, whereIdTo: 5));
}
