import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ChatModel.dummyData.length,
      itemBuilder: (context, index) {
        final ChatModel chat = ChatModel.dummyData[index];
        return Column(
          children: <Widget>[
            const Divider(height: 10.0),
            ListTile(
              leading: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(chat.avatarUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    chat.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chat.time,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  chat.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
