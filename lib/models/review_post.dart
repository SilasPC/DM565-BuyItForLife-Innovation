import '../database.dart';

class ReviewPost {
  final int id;
  final String title;
  final String? badge;
  final String img;
  final int stars;
  final String popularity;
  final String category;
  final String firstComment;

  const ReviewPost(this.id, this.title, this.img, this.stars, this.popularity,
      this.badge, this.category, this.firstComment);

  static Future<List<ReviewPost>> query({String pat = "", String? cat}) async {
    var db = await BackendDatabase.instance;
    var res = await db.db.query(
        "SELECT DISTINCT ON (posts.id) posts.*, comment FROM posts LEFT JOIN comments ON reviewId = posts.id WHERE title ILIKE @pat AND category LIKE @cat",
        substitutionValues: {"pat": "%$pat%", "cat": cat ?? "%"});
    return res
        .map((r) => ReviewPost(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7] ?? ""))
        .toList();
  }

  static Future<void> create(String title, String img) async {
    var db = await BackendDatabase.instance;
    // todo: don't use SQL injection
    await db.db.execute(
        "INSERT INTO posts(title, badge, img, stars, popularity) VALUES ('$title', '', '$img', 0, 0);");
  }
}
