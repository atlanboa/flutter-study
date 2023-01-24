import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_completion/resources/stroage_method.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occured";
    try {
      String photoUrl = await StorageMethods()
          .addImageToStorage(childName: 'posts', file: file, isPost: true);

      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        postUrl: photoUrl,
        profImages: profImage,
        datePublished: DateTime.now(),
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(
      {required String postId,
      required String uid,
      required List likes}) async {
    try {
      if (likes.contains(uid)) {
        likes.remove(uid);
      } else {
        likes.add(uid);
      }
      await _firestore.collection('posts').doc(postId).update(
        {
          'likes': likes,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> commentPost({
    required String postId,
    required String uid,
    required String comment,
    required String username,
    required String profImage,
  }) async {
    try {
      var commentId = const Uuid().v1();
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
        'commentId': commentId,
        'uid': uid,
        'comment': comment,
        'username': username,
        'profImage': profImage,
        'datePublished': DateTime.now(),
        'likes': [],
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeComment({
    required String postId,
    required String commentId,
    required String uid,
    required bool isLiked,
  }) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .update({
        'likes': isLiked
            ? FieldValue.arrayRemove([uid])
            : FieldValue.arrayUnion([uid]),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost({required String postId}) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
