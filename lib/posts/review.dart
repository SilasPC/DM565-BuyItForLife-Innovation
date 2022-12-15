import 'package:flutter/material.dart';
import '../models/review_post.dart';
import 'badge.dart';
import 'review_comments_dialog.dart';
import 'vote_mockup.dart';
import 'starsbar.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem(this.post, {super.key});

  final ReviewPost post;

  Future<void> showComments(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ReviewCommentsDialog(post),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => showComments(context),
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 5,
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(post.img), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (post.badge == null) StarsBar(post.stars),
                    const Spacer(),
                    VoteButtons(post.popularity),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(),
                    Text(post.firstComment, maxLines: 3),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _title() {
    var t = Text(post.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
    if (post.badge == null) {
      return t;
    } else {
      return Row(
        children: [
          Badge(post.badge!),
          Expanded(child: t),
        ],
      );
    }
  }
}
