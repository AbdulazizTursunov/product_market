
import 'package:path/path.dart';
import 'package:product_market/data/model/chiqim_model.dart';
import 'package:product_market/data/model/product_model.dart';
import 'package:product_market/data/model/qoldiq_model.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

SQLiteWrapper db = SQLiteWrapper();

class DbInitialize {
  DbInitialize._init();
  static final DbInitialize _singelton = DbInitialize._init();

  factory DbInitialize() {
    return _singelton;
  }
  static int version = 1;

  Future<DatabaseInfo> initDb(dbPath, {inMemory = true}) async {
    dbPath = join(dbPath, "base.sqlite");
    return db.openDB(
      dbPath,
      version: version,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate() async {
    List sql = [];
    sql.add(ProductService.productTableCreate);
    sql.add(ChiqimServce.chiqimTableCreate);
    sql.add(QoldiqServise.qoldiqTableCreate);

    for (var query in sql) {
      db.execute(query);
    }
  }
}
