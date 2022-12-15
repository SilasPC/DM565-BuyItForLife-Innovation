import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String tag;
  const Badge(this.tag, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(tag),
      );
}
