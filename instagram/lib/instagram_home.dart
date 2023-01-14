import 'package:flutter/material.dart';

import 'instagram_body.dart';

class InstagramHome extends StatefulWidget {
  const InstagramHome({super.key});

  @override
  State<InstagramHome> createState() => _InstagramHomeState();
}

class _InstagramHomeState extends State<InstagramHome> {
  final topBar = AppBar(
    leading: const Icon(Icons.camera_alt),
    title: const SizedBox(
      height: 35,
      child: Image(
        image: AssetImage(
          'assets/images/insta_logo.png',
        ),
      ),
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Icon(Icons.send),
      ),
    ],
  );

  var bottomAppBar = BottomAppBar(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.add_box),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {},
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar,
      body: const InstaBody(),
      bottomNavigationBar: bottomAppBar,
    );
  }
}
