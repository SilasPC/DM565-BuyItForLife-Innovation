import 'package:flutter/material.dart';
import '../models/review_post.dart';
import '../posts/create_post_dialog.dart';
import '../posts/review.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  TextEditingController search = TextEditingController();
  List<ReviewPost> posts = [];

  Future<void> loadPosts() async {
    var pat = search.text.replaceAll(RegExp(r"\s+"), "%");
    var res = await ReviewPost.query(pat: pat);
    setState(() {
      posts = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    var items =
        posts.map((p) => SizedBox(width: 280, child: ReviewItem(p))).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SingleChildScrollView(
              child: Wrap(
                children: items,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            color: const Color.fromARGB(255, 228, 228, 228),
          ),
          padding: const EdgeInsets.all(16),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text("Filter",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              TextField(
                onEditingComplete: loadPosts,
                controller: search,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateForumPostDialog(),
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
            ],
          ),
        )
      ],
    );
  }
}
