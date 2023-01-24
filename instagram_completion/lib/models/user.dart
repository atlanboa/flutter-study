import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };

  User.fromSnap(DocumentSnapshot snap)
      : uid = snap['uid'],
        username = snap['username'],
        email = snap['email'],
        bio = snap['bio'],
        photoUrl = snap['photoUrl'] ?? "no photo",
        followers = snap['followers'],
        following = snap['following'];

  User fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'],
        username: json['username'],
        email: json['email'],
        bio: json['bio'],
        photoUrl: json['photoUrl'],
        followers: json['followers'],
        following: json['following'],
      );
}
