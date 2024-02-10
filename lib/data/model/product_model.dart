import 'package:flutter/material.dart';
import 'package:product_market/data/data/crud_service.dart';
import 'package:product_market/data/data/db_initialize.dart';
import 'package:product_market/data/model/qoldiq_model.dart';

class Product {
  static CrudService service = ProductService();
  static Map<int, Product> obektlar = {};

  Product();

  int tr = 0;
  String nomi = '';
  num kelNarx = 0;
  num sotNarx = 0;
  num miqdor = 0;
  DateTime time = DateTime.now();

  Qoldiq get qoldiq => Qoldiq.obektlar[tr] ?? Qoldiq();

  Product.fromJson(Map<String, dynamic> json) {
    tr = int.parse(json['tr'].toString());
    nomi = json['nomi'].toString();
    kelNarx = num.tryParse(json['kelNarx'].toString()) ?? 0;
    sotNarx = num.tryParse(json['sotNarx'].toString()) ?? 0;
    time = DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(json['time'].toString()) ?? 0);
    miqdor = num.tryParse(json['miqdor'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'tr': tr,
      'nomi': nomi,
      'kelNarx': kelNarx,
      'sotNarx': sotNarx,
      'miqdor': miqdor,
      'time': time.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return """  
     tr: $tr,
      nomi: $nomi,
      kelNarx: $kelNarx,
      sotNarx: $sotNarx,
      miqdor: $miqdor,
      time: $time,
""";
  }

   Future<int> insert() async {
    tr = await service.insert(toJson());
    Product.obektlar[tr] = this;
    return tr;
  }

  Future<void> delete() async {
    Product.obektlar.remove(tr);
    await service.delete(where: "tr='$tr'");
  }

  Future<void> update() async {
    Product.obektlar[tr] = this;
    await service.update(toJson(), where: "tr='$tr'");
  }
}

class ProductService extends CrudService {
  @override
  ProductService({super.prefix = ''}) : super("product");

  static String productTableCreate = """
  CREATE TABLE "product" (
  "tr" INTEGER,
  "nomi" TEXT NOT NULL DEFAULT '',
  "kelNarx" NUMERIC NOT NULL DEFAULT 0,
  "sotNarx" NUMERIC NOT NULL DEFAULT 0,
  "miqdor" NUMERIC NOT NULL DEFAULT 0,
  "time" INTEGER,
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
    debugPrint('ProductService "update" method ishladi');
  }

  @override
  Future<void> delete({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    await db.query("DELETE FROM $table $where");
    debugPrint('ProductService "delete" method ishladi');
  }

  @override
  Future<int> insert(Map map) async {
    map['tr'] = (map['tr'] == 0) ? null : map['tr'];
    var insertM = await db.insert(map as Map<String, dynamic>, table);
    debugPrint('ProductService "insert" method ishladi');
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
    debugPrint("ProductService select method ishladi");
    return map;
  }
}
