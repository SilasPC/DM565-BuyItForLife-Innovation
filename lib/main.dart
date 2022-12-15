import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'web_layout.dart';
import 'pages/media.dart';
import 'pages/forum.dart';
import 'pages/home.dart';
import 'pages/market.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  Widget page = const Home();

  @override
  Widget build(BuildContext context) => WebLayout(
        body: page,
        login: const CircleAvatar(
          child: Text("S"),
        ),
        navigationItems: [
          menuButton(FontAwesomeIcons.house, "Home", () => const Home(), 0),
          menuButton(FontAwesomeIcons.solidComment, "Forum",
              () => const ForumPage(), 1),
          menuButton(FontAwesomeIcons.shop, "Market", () => const Market(), 2),
          menuButton(
              FontAwesomeIcons.video, "Media", () => const MediaPage(), 3),
        ],
      );

  Widget menuButton(
      IconData icon, String label, Widget Function() f, int index) {
    return TextButton(
      onPressed: () => setState(() {
        pageIndex = index;
        page = f();
      }),
      child: Container(
        width: 110,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: index != pageIndex
              ? const Color.fromARGB(255, 253, 250, 245)
              : const Color.fromARGB(255, 212, 212, 212),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon),
            Text(label),
          ],
        ),
      ),
    );
  }
}
