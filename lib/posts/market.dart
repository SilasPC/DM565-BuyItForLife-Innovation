import 'package:flutter/material.dart';
import '../models/market_post.dart';

class MarketItem extends StatelessWidget {
  const MarketItem(this.post, {super.key});
  final MarketPost post;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            elevation: 5,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.img), fit: BoxFit.cover),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(172, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                padding: const EdgeInsets.all(8.0),
                child: Text(post.price,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 20,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  //Text("This was literally the most insane experience of my life. I could not believe how amazing this could be."),
                ],
              ),
            ),
          ),
        ],
      );
}
