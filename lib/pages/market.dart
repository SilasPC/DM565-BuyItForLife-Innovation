import 'package:flutter/material.dart';
import 'package:formsprog/web_layout.dart';
import '../models/market_post.dart';
import '../posts/create_market_post_dialog.dart';
import '../posts/market.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    var pat = search.text.replaceAll(RegExp(r"\s+"), "%");
    var res = await MarketPost.query(pat: pat);
    setState(() {
      posts = res;
    });
  }

  List<MarketPost> posts = [];
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: SingleChildScrollView(
              child: Wrap(children: [
                for (var post in posts)
                    MarketItem(post),
              ]),
            ),
          ),
        ),
        Container(
          decoration: WebLayout.sidebarDecoration,
          padding: const EdgeInsets.all(16),
          width: 200,
          child: Column(children: [
            const Text("Filter",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              onEditingComplete: loadPosts,
              controller: search,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const Spacer(),
            Center(
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateMarketPostDialog(),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text("Create post",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              )
          ]),
        )
      ],
    );
  }
}
