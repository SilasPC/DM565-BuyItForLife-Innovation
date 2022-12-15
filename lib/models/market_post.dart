import 'package:formsprog/database.dart';

class MarketPost {
  final int id;
  final String title;
  final String price;
  final String img;

  const MarketPost(this.id, this.title, this.price, this.img);

  static Future<List<MarketPost>> query({String pat = ""}) async {
    var res = await (await BackendDatabase.instance).db.query(
        "SELECT * FROM market_posts WHERE title ILIKE @pat",
        substitutionValues: {"pat": "%$pat%"});
    return res.map((r) => MarketPost(r[0], r[1], r[3], r[2])).toList();
  }

  static Future<void> create(String title, String img, String price) async {
    var db = await BackendDatabase.instance;
    // todo: don't use SQL injection
    await db.db.execute(
        "INSERT INTO market_posts(title, img, price) VALUES ('$title', '$img', '$price');");
  }
}
