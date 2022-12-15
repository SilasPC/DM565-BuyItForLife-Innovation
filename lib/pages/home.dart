import 'package:flutter/material.dart';
import '../models/market_post.dart';
import '../models/review_post.dart';
import '../posts/market.dart';
import '../posts/review.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  List<ReviewPost> posts = [];
  List<MarketPost> market = [];

  Future<void> loadPosts() async {
    var res1 = await ReviewPost.query();
    var res2 = await MarketPost.query();
    setState(() {
      posts = res1;
      market = res2;
    });
  }

  @override
  Widget build(BuildContext context) {
    var items1 = posts.map((p) => ReviewItem(p)).toList();
    var items2 = market.map((p) => MarketItem(p)).toList();
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Forum",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items1,
            ),
          ),
          const Text("Market",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 270,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items2,
            ),
          ),
          const Text("Media",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 400,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items1.reversed.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
