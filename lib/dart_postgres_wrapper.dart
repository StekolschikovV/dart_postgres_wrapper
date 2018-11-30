import 'package:postgres/postgres.dart';
import 'dart:async';
import './dataType.dart';

class PG {

  String host;
  int port;
  String user;
  String pass;
  String db;
  String tab;

  var connection;

  PG(this.host, this.port, this.db, this.user, this.pass, this.tab);

  void createConnection() async {
    connection = new PostgreSQLConnection(this.host, this.port, this.db, username: this.user, password: this.pass);
    await connection.open();
  }

  void createTable(List<FieldAndType> fields) async {
    try{
      String fieldsStr = '';
      fields.forEach((e){
        if(fieldsStr.length > 0)
          fieldsStr += ', ';
        fieldsStr += '${e.field} ${e.type}';
      });
      String queryStr = "CREATE TABLE $tab($fieldsStr);";
      await connection.query(queryStr);
    } catch(e){
      print('Error: $e');
    }
  }

  void drop() async {
    String queryStr = "DROP TABLE $tab;";
    await connection.query(queryStr);
  }

  void copy(String path, {bool isCsv = false}) async {
    String queryStr = "COPY $tab FROM '$path' ${isCsv ? 'WITH (FORMAT csv)' : ''};";
    await connection.query(queryStr);
  }

  void replace(String col, String from, String to) async {
    String queryStr = "UPDATE $tab SET $col = replace($col, '$from', '$to');";
    await connection.query(queryStr);
  }

  void setPrimaryKey() async {
    String queryStr = 'ALTER TABLE $tab ADD COLUMN id SERIAL PRIMARY KEY;';
    await connection.query(queryStr);
  }

  void setColType(String col, String type) async {
    String queryStr = "ALTER TABLE $tab ALTER COLUMN $col SET DATA TYPE $type USING $col::$type;";
    await connection.query(queryStr);
  }

  Future<List> select({String what = '*', var where = false, var whereIdFrom = false, var whereIdTo = false}) async {
    String queryStr = "SELECT $what FROM $tab ${where != false ? where : '' }${whereIdFrom != false && whereIdTo != false ? 'WHERE id >= ${whereIdFrom} AND id <= ${whereIdTo}' : ''};";
    List<List<dynamic>> res = await connection.query(queryStr);
    return res;
  }

  void insert(List<String> col, List val) async {
    assert(col.length == val.length);
    String colStr = col.toString().replaceAll('[', '').replaceAll(']', '');
    String valStr = '';
    val.forEach((e){
      if(valStr.length > 0)
        valStr += ' ,';
      valStr += e is double || e is int ? e.toString() : '\'${e.toString()}\'' ;
    });
    String queryStr = "INSERT INTO $tab ($colStr) VALUES ($valStr);";
    await connection.query(queryStr);
  }

  void deleteAll() async {
    String queryStr = "DELETE FROM $tab;";
    await connection.query(queryStr);
  }
}