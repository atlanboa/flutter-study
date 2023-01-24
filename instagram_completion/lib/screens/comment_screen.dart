import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_completion/resources/firestore_method.dart';
import 'package:instagram_completion/utils/colors.dart';
import 'package:instagram_completion/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class CommentScreen extends StatefulWidget {
  final dynamic snap;
  const CommentScreen({
    this.snap,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: (snapshot.data as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index],
              postId: widget.snap['postId'],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.photoUrl,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: TextField(
                      controller: _commentController,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: "Add a comment...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  FirestoreMethods().commentPost(
                    postId: widget.snap['postId'],
                    uid: user.uid,
                    comment: _commentController.text,
                    username: user.username,
                    profImage: user.photoUrl,
                  );
                  setState(() {
                    _commentController.text = "";
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
