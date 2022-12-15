import 'package:flutter/material.dart';

class VoteButtons extends StatefulWidget {
  const VoteButtons(this.pop, {super.key});

  final String pop;

  @override
  State<VoteButtons> createState() => VoteButtonsState();
}

class VoteButtonsState extends State<VoteButtons> {
  static const Color col = Colors.redAccent;
  bool? like;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(5),
        width: 70,
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color.fromARGB(115, 255, 255, 255),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 4,
              child: IconButton(
                splashRadius: 8,
                onPressed: () => setState(() => like = true),
                icon: Icon(Icons.keyboard_arrow_up,
                    color: like == true ? col : null),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(widget.pop, style: const TextStyle(fontSize: 25)),
            ),
            Transform.scale(
              scale: 4,
              child: IconButton(
                splashRadius: 8,
                onPressed: () => setState(() => like = false),
                icon: Icon(Icons.keyboard_arrow_down,
                    color: like == false ? col : null),
              ),
            ),
          ],
        ),
      );
}
