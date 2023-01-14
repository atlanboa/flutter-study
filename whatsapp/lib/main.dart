import 'package:flutter/material.dart';
import 'package:whatsapp/screens/whatsapp_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      theme: ThemeData(
        primaryColor: const Color(0xff075E54),
        backgroundColor: const Color.fromARGB(255, 32, 111, 102),
      ),
      home: const WhatsAppHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
