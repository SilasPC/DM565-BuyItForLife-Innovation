import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formsprog/web_layout.dart';
import '../models/review_post.dart';
import '../posts/review.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  String? category;
  TextEditingController search = TextEditingController();
  List<ReviewPost> posts = [];

  Future<void> loadPosts() async {
    var pat = search.text.replaceAll(RegExp(r"\s+"), "%");
    var res = await ReviewPost.query(pat: pat, cat: category);
    setState(() {
      posts = res;
    });
  }

  bool isSearchView() => search.text.isNotEmpty || category != null;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 28, left: 8),
          child: isSearchView() ? buildSearchView() : buildNonSearchView(),
        )),
        Container(
          decoration: WebLayout.sidebarDecoration,
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
              Center(
                child: DropdownButton(
                  hint: const Text("Category..."),
                  value: category,
                  onChanged: (value) {
                    setState(() {
                      category = value;
                    });
                    loadPosts();
                  },
                  items: const [
                    DropdownMenuItem(value: null, child: Text("Any")),
                    DropdownMenuItem(
                        value: 'restoration', child: Text("Restoration")),
                    DropdownMenuItem(
                        value: 'unboxing', child: Text("Unboxing")),
                  ],
                ),
              ),
              const Divider(),
              itemHead("Subscriptions"),
              vspace,
              item(FontAwesomeIcons.solidCircleUser, "Marcus Willow"),
              item(FontAwesomeIcons.solidCircleUser, "Emily Hunter"),
              vspace,
              const Divider(),
              itemHead("Explore"),
              vspace,
              item(FontAwesomeIcons.fire, "Hot now"),
              item(FontAwesomeIcons.video, "Videos"),
              item(FontAwesomeIcons.blog, "Blog posts"),
              const Spacer(),
              const Center(
                  child: Text("Daily News",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSearchView() => SingleChildScrollView(
        child: Wrap(
          children: [for (var post in posts) ReviewItem(post)],
        ),
      );

  Widget buildNonSearchView() {
    return ListView(
      children: [
        const Text("Hot", style: sepSty),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: posts.map((p) => ReviewItem(p)).toList(),
          ),
        ),
        const Text("Video", style: sepSty),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: posts.reversed.map((p) => ReviewItem(p)).toList(),
          ),
        ),
        const Text("Blog", style: sepSty),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: posts.map((p) => ReviewItem(p)).toList(),
          ),
        ),
      ],
    );
  }

  Widget itemHead(String label) => Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );

  Widget item(IconData icon, String label) => Row(children: [
        Icon(icon, size: 16),
        Text("  $label", style: const TextStyle(fontSize: 16))
      ]);
}

const vspace = SizedBox(height: 10);
const sepSty = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
