import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_completion/resources/firestore_method.dart';
import 'package:instagram_completion/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class CommentCard extends StatefulWidget {
  final dynamic snap;
  final String postId;
  const CommentCard({
    super.key,
    this.snap,
    required this.postId,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  void initState() {
    super.initState();
    print(widget.snap);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  widget.snap['profImage'],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.snap['username'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: DateFormat.yMMMd().format(
                                widget.snap['datePublished'].toDate(),
                              ),
                              style: TextStyle(
                                color: secondaryColor.shade500,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.snap['comment'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.postId)
                      .collection('comments')
                      .doc(widget.snap['commentId'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final isLiked =
                        (snapshot.data as dynamic)['likes'].contains(user.uid);
                    return IconButton(
                      onPressed: () {
                        FirestoreMethods().likeComment(
                          postId: widget.postId,
                          commentId: widget.snap['commentId'],
                          uid: user.uid,
                          isLiked: isLiked,
                        );
                      },
                      icon: isLiked
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
