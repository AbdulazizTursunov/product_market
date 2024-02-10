import 'package:flutter/material.dart';
import 'package:product_market/data/data/crud_service.dart';
import 'package:product_market/data/data/db_initialize.dart';

class Qoldiq {
  Qoldiq();

  static CrudService service = QoldiqServise();
  static Map<int, Qoldiq> obektlar = {};
  int tr = 0;
  int trBoboQoldiq = 0;
  String nomi = 'Nomalum';
  num qoldiq = 0.0;

  Qoldiq.fromJson(Map<String, dynamic> json) {
    tr = int.parse(json['tr'].toString());
    trBoboQoldiq = int.parse(json['trBoboQoldiq'].toString());
    nomi = json['nomi'].toString();
    qoldiq = num.tryParse(json['qoldiq'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'tr': tr,
      'trBoboQoldiq': trBoboQoldiq,
      'nomi': nomi,
      'qoldiq': qoldiq,
    };
  }

  @override
  String toString() {
    return """  
      tr: $tr
      trBoboQoldiq:$trBoboQoldiq,
      nomi: $nomi,
      qoldiq: $qoldiq,
     
    """;
  }

  Future<int> insert() async {
    tr = await service.insert(toJson());
    Qoldiq.obektlar[tr] = this;
    return tr;
  }

  Future<void> delete() async {
    Qoldiq.obektlar.remove(tr);
    await service.delete(where: "tr='$tr'");
  }

  Future<void> update() async {
    Qoldiq.obektlar[tr] = this;
    await service.update(toJson(), where: "tr='$tr'");
  }
}

class QoldiqServise extends CrudService {
  @override
  QoldiqServise({super.prefix = ''}) : super("qoldiq");

  static String qoldiqTableCreate = """
  CREATE TABLE "qoldiq" (
  "tr" INTEGER NOT NULL DEFAULT 0,
  "trBoboQoldiq" INTEGER NOT NULL DEFAULT 0,
  "trBobo" INTEGER NOT NULL DEFAULT 0,
  "nomi" TEXT NOT NULL DEFAULT '',
  "qoldiq" NUMERIC NOT NULL DEFAULT 0,
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
    debugPrint('QoldiqServise "update" method ishladi');
  }

  @override
  Future<void> delete({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    await db.query("DELETE FROM $table $where");
    debugPrint('QoldiqServise "delete" method ishladi');
  }

  @override
  Future<int> insert(Map map) async {
    map['tr'] = (map['tr'] == 0) ? null : map['tr'];
    var insertM = await db.insert(map as Map<String, dynamic>, table);
    debugPrint('QoldiqServise "insert" method ishladi');
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
    debugPrint("QoldiqServise select method ishladi");
    return map;
  }
}
