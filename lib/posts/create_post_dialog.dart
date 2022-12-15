import 'package:flutter/material.dart';
import '../models/review_post.dart';

class CreateForumPostDialog extends StatefulWidget {
  const CreateForumPostDialog({super.key});

  @override
  State<CreateForumPostDialog> createState() => _CreateForumPostDialogState();
}

class _CreateForumPostDialogState extends State<CreateForumPostDialog> {
  TextEditingController title = TextEditingController(),
      url = TextEditingController();

  @override
  Widget build(BuildContext context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(16),
        title: Stack(
          alignment: Alignment.centerRight,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
            const Center(
              child: Text("New post"),
            )
          ],
        ),
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: url,
            decoration: const InputDecoration(hintText: "Image URL"),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: submit,
              child: const Text("Submit"))
        ],
      );

  Future<void> submit() async {
    await ReviewPost.create(title.text, url.text);
    if (mounted) Navigator.pop(context);
  }
}
