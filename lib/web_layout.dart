import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  final Widget body;
  final List<Widget> navigationItems;
  final Widget login;

  static final BoxDecoration sidebarDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
    ),
    color: const Color.fromARGB(255, 228, 228, 228),
  );

  const WebLayout(
      {required this.body,
      required this.login,
      required this.navigationItems,
      super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color.fromARGB(255, 208, 208, 208),
                child: Row(
                  children: [
                    const Text(
                      // wacky centering sorry
                      "        B4L",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const Spacer(),
                    const Text("Buy It Once, Buy It For Life",
                        style: TextStyle(fontSize: 24)),
                    const Spacer(),
                    login
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: sidebarDecoration,
                      child: Column(
                        children: navigationItems,
                      ),
                    ),
                    Expanded(child: body),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
