import 'package:flutter/material.dart';
import '../models/market_post.dart';

class CreateMarketPostDialog extends StatefulWidget {
  const CreateMarketPostDialog({super.key});

  @override
  State<CreateMarketPostDialog> createState() => _CreateForumPostDialogState();
}

class _CreateForumPostDialogState extends State<CreateMarketPostDialog> {
  TextEditingController title = TextEditingController(),
      url = TextEditingController(),
      price = TextEditingController();

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
              child: Text("New sales post"),
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
          TextField(
            controller: price,
            decoration: const InputDecoration(hintText: "Price"),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: submit,
              child: const Text("Submit"))
        ],
      );

  Future<void> submit() async {
    await MarketPost.create(title.text, url.text, price.text);
    if (mounted) Navigator.pop(context);
  }
}
