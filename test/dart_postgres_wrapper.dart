import 'package:dart_postgres_wrapper/dart_postgres_wrapper.dart';
import 'package:dart_postgres_wrapper/data_type.dart';
import 'package:test/test.dart';

void main() async {
  String host = 'localhost';
  int pgPort = 5432;
  String db = 'test';
  String dbUser = 'postgres';
  String dbPassword = 'newPassword';
  String tab = 'datatoimport2';
  int from = 0;
  int to = 2;

  PG pg = new PG(host, pgPort, db, dbUser, dbPassword, tab);
  await pg.createConnection();

  test('select', () async {
    var res = await pg.select(whereIdFrom: from, whereIdTo: to);
    expect(res.length, 2);
  });

  test('count', () async {
    expect(await pg.getCount(), 1000000);
  });
}
