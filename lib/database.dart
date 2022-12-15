import 'package:postgres/postgres.dart';

class BackendDatabase {
  static Future<BackendDatabase>? _instance;
  static Future<BackendDatabase> get instance =>
      _instance ??= BackendDatabase._init();
  static Future<BackendDatabase> _init() async {
    // todo: create proper backend
    var db = PostgreSQLConnection("localhost", 5432, "buy_it_for_life",
        username: "admin", password: "admin");
    await db.open();
    return BackendDatabase._(db);
  }

  final PostgreSQLConnection db;
  BackendDatabase._(this.db);

  Future<List<String>> getComments(int reviewId) async {
    var res = await db
        .query("SELECT comment FROM comments WHERE reviewId = $reviewId");
    return res.map((r) => r[0] as String).toList();
  }
}
