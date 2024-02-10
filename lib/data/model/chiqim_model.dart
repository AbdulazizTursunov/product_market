import 'package:flutter/material.dart';
import 'package:product_market/data/data/crud_service.dart';
import 'package:product_market/data/data/db_initialize.dart';

class Chiqim{
  Chiqim();
  static CrudService service = ChiqimServce();
  static Map<int, Chiqim> obektlar = {};
 int tr= 0;
  int trBoboChiqim=0;
  String nomi = '';
  num sotildiMiqdor = 0.0;
  DateTime time = DateTime.now();
  num sotildiPrice = 0.0;

  Chiqim.fromJson(Map<String, dynamic> json) {
    tr = int.parse(json['tr'].toString());
    trBoboChiqim = int.parse(json['trBoboChiqim'].toString());
    nomi = json['nomi'].toString();
    sotildiMiqdor = num.tryParse(json['sotildiMiqdor'].toString()) ?? 0;
    time = DateTime.fromMillisecondsSinceEpoch(int.tryParse(json['time'].toString()) ?? 0);
    sotildiPrice = num.tryParse(json['sotildiPrice'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'tr':tr,
      'trBoboChiqim':trBoboChiqim,
      'nomi': nomi,
      'sotildiMiqdor': sotildiMiqdor,
      'time': time.millisecondsSinceEpoch,
      'sotildiPrice': sotildiPrice,
    };
  }

  @override
  String toString() {
    return """  
    tr: $tr
      trBoboChiqim:$trBoboChiqim,
      nomi: $nomi,
      sotildiMiqdor: $sotildiMiqdor,
      time: $time,
      sotildiPrice: $sotildiPrice,
    """;
  }

  Future<int> insert() async {
    tr = await service.insert(toJson());
    Chiqim.obektlar[tr] = this;
    return tr;
  }

  Future<void> delete() async {
    Chiqim.obektlar.remove(tr);
    await service.delete(where: "tr='$tr'");
  }

  Future<void> update() async {
    await service.update(toJson(), where: "tr='$tr'");
    Chiqim.obektlar[tr] = this;
  }
}

class ChiqimServce extends CrudService {
  @override
  ChiqimServce({super.prefix = ''}) : super("chiqim");


  static String chiqimTableCreate = """
  CREATE TABLE "chiqim" (
  "tr" INTEGER NOT NULL DEFAULT 0,
  "trBoboChiqim" INTEGER NOT NULL DEFAULT 0,
  "nomi" TEXT NOT NULL DEFAULT '',
  "sotildiMiqdor" NUMERIC NOT NULL DEFAULT 0,
  "time" INTEGER,
  "sotildiPrice" NUMERIC NOT NULL DEFAULT 0,
  PRIMARY KEY("tr" AUTOINCREMENT)
  );
  """;

  @override
  Future<void> update(Map map, {String? where}) async {
    where = where == null ? "" : "WHERE $where";

    String updateClause = "";
    final List params = [];
    final values = map.keys;

    for (String value in values) {
      if (updateClause.isNotEmpty) updateClause += ", ";
      updateClause += "$value=?";
      params.add(map[value]);
    }
    final String sql = "UPDATE $table SET $updateClause$where";
    await db.execute(sql, tables: [table], params: params);
    debugPrint('ChiqimServce "update" method ishladi');
  }

  @override
  Future<void> delete({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    await db.query("DELETE FROM $table $where");
    debugPrint('ChiqimServce "delete" method ishladi');
  }

  @override
  Future<int> insert(Map map) async {
    map['tr'] = (map['tr'] == 0) ? null : map['tr'];
    var insertM = await db.insert(map as Map<String, dynamic>, table);
    debugPrint('ChiqimServce "insert" method ishladi');
    return insertM;
  }

  @override
  Future<Map> select({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    Map<int, dynamic> map = {};
    await for (final rows
    in db.watch("SELECT * FROM $table $where", tables: [table])) {
      for (final element in rows) {
        map[element['tr']] = element;
      }
      return map;
    }
    debugPrint("ChiqimServce select method ishladi");
    return map;
  }
}
