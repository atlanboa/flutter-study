import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_completion/resources/stroage_method.dart';
import 'package:instagram_completion/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }
      // Uint8List file,
      ) async {
    String res = "Some error occus";
    try {
      if (email.isNotEmpty &&
              password.isNotEmpty &&
              username.isNotEmpty &&
              bio.isNotEmpty
          // && file.isNotEmpty
          ) {
        final UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // upload image to firebase storage
        String photoUrl = await StorageMethods().addImageToStorage(
            childName: 'profilePic', file: file, isPost: false);

        model.User user = model.User(
          uid: cred.user!.uid,
          username: username,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        // add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        // add user profile picture to our storage
        // await
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'Your email address appears to be malformed.';
      } else if (e.code == "weak-password") {
        res = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        res = "The account already exists for that email.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // sign in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "error";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = 'Wrong password provided';
      } else if (e.code == 'user-not-found') {
        res = 'No user found for that email';
      } else if (e.code == 'invalid-email') {
        res = 'Your email address appears to be malformed.';
      }
    } catch (e) {
      print(e.toString());
    }

    return res;
  }

  Future<model.User> getUserDetails() async {
    User? user = _auth.currentUser;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(user!.uid).get();
    return model.User.fromSnap(snap);
  }
}
