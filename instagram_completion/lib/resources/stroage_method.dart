import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firestore = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to firebase storage
  Future<String> addImageToStorage({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    Reference ref =
        _firestore.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      final id = const Uuid().v1();
      ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
