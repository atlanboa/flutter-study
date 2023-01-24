import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsernmae();
  }

  void getUsernmae() async {
    final uid = _auth.currentUser!.uid;
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      username = snap['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is web screen layout : $username"),
      ),
    );
  }
}
