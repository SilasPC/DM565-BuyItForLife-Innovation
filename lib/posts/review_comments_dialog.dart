import 'package:flutter/material.dart';
import '../database.dart';
import '../models/review_post.dart';

class ReviewCommentsDialog extends StatefulWidget {
  const ReviewCommentsDialog(this.post, {super.key});

  final ReviewPost post;

  @override
  State<ReviewCommentsDialog> createState() => _ReviewCommentsDialogState();
}

class _ReviewCommentsDialogState extends State<ReviewCommentsDialog> {
  List<String> cmts = [];

  Future<void> getComments() async {
    var cmts =
        await (await BackendDatabase.instance).getComments(widget.post.id);
    setState(() {
      this.cmts = cmts;
    });
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 300, vertical: 100),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Text(widget.post.title,
                  style: const TextStyle(
                      fontSize: 36,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold))),
        ),
        SizedBox(height: 300, child: Image.network(widget.post.img)),
        for (var cmt in cmts) ...[ListTile(title: Text(cmt)), const Divider()],
      ],
    );
  }
}
