import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_completion/providers/user_provider.dart';
import 'package:instagram_completion/resources/firestore_method.dart';
import 'package:instagram_completion/screens/comment_screen.dart';
import 'package:instagram_completion/utils/colors.dart';
import 'package:instagram_completion/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentsLen = 0;

  Future<Widget> buildCommentPageAsync() async {
    return Future.microtask(() => const CommentScreen());
  }

  void likePost({required String uid}) async {
    setState(() {
      widget.snap['likes'].contains(uid)
          ? isLikeAnimating = false
          : isLikeAnimating = true;
    });
    FirestoreMethods().likePost(
      postId: widget.snap.id,
      uid: uid,
      likes: widget.snap['likes'],
    );
  }

  @override
  void initState() {
    super.initState();
    getCommentsLen();
  }

  void getCommentsLen() async {
    int len = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .get()
        .then((value) => value.docs.length);
    setState(() {
      commentsLen = len;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser(context);

    print("postUrl : " + widget.snap['postUrl']);
    print("description : " + widget.snap['description']);
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImages']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            children: ['Delete']
                                .map((e) => InkWell(
                                      onTap: () async {
                                        await FirestoreMethods().deletePost(
                                            postId: widget.snap['postId']);
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        child: Text(e),
                                      ),
                                    ))
                                .toList()),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),

          // Image section
          GestureDetector(
            onDoubleTap: () {
              likePost(uid: user.uid);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  opacity: isLikeAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 100),
                    smallLike: false,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                duration: const Duration(milliseconds: 500),
                smallLike: true,
                onEnd: () {
                  setState(() {
                    isLikeAnimating = false;
                  });
                },
                child: IconButton(
                  onPressed: () => likePost(uid: user.uid),
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: primaryColor,
                        ),
                ),
              ),

              // comment icon
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(snap: widget.snap),
                  ),
                ),
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: primaryColor,
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.send,
                  color: primaryColor,
                ),
              ),
              const Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: primaryColor,
                  ),
                ),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  child: Text(
                    "${widget.snap['likes'].length} likes",
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                // comment
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "View all $commentsLen comments",
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
