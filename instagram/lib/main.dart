import 'package:flutter/material.dart';
import 'package:instagram/instagram_home.dart';

void main() {
  runApp(const InstagramApp());
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  final Color primaryColor = Colors.black;

  final AppBarTheme appBarTheme = const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );

  final primaryIconTheme = const IconThemeData(
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          appBarTheme: appBarTheme,
          fontFamily: "Aveny",
          primaryIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          primaryTextTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontFamily: "Aveny",
            ),
            titleMedium: TextStyle(
              color: Colors.black,
              fontFamily: "Aveny",
            ),
            titleSmall: TextStyle(
              color: Colors.black,
              fontFamily: "Aveny",
            ),
          )),
      home: const InstagramHome(),
    );
  }
}
