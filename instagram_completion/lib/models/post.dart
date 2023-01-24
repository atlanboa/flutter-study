import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String username;
  final String description;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImages;
  final likes;

  const Post({
    required this.uid,
    required this.username,
    required this.description,
    required this.postId,
    required this.postUrl,
    required this.profImages,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'description': description,
        'postId': postId,
        'postUrl': postUrl,
        'profImages': profImages,
        'datePublished': datePublished,
        'likes': likes,
      };

  Post.fromSnap(DocumentSnapshot snap)
      : uid = snap['uid'],
        username = snap['username'],
        description = snap['description'],
        postId = snap['postId'],
        datePublished = snap['datePublished'],
        postUrl = snap['followers'],
        profImages = snap['following'],
        likes = snap['likes'];

  Post fromJson(Map<String, dynamic> json) => Post(
        uid: json['uid'],
        username: json['username'],
        description: json['description'],
        postId: json['postId'],
        postUrl: json['postUrl'],
        profImages: json['profImages'],
        datePublished: json['datePublished'],
        likes: json['likes'],
      );
}
