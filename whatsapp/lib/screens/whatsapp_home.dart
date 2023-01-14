import 'package:flutter/material.dart';
import 'package:whatsapp/screens/camera_screen.dart';
import 'package:whatsapp/screens/status_screen.dart';

import 'call_screen.dart';
import 'chat_screen.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      initialIndex: 1,
      length: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => print('search'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => print('more'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CameraScreen(),
          ChatScreen(),
          StatusScreen(),
          CallScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).backgroundColor,
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () => print('open chats'),
      ),
    );
  }
}

class CallsScreen {}
