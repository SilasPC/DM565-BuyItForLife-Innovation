import 'package:flutter/material.dart';

class StarsBar extends StatelessWidget {
  const StarsBar(this.stars, {super.key});

  final int stars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _stars,
      ),
    );
  }

  List<Widget> get _stars {
    int full = stars ~/ 2;
    bool half = stars % 2 == 1;
    int empty = (10 - stars) ~/ 2;
    return [
      ...List.filled(empty, const Icon(Icons.star_border, color: Colors.amber)),
      if (half) const Icon(Icons.star_half, color: Colors.amber),
      ...List.filled(full, const Icon(Icons.star, color: Colors.amber)),
    ];
  }
}
