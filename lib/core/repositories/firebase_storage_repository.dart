import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepoProvider = Provider((ref) => CommonFirebaseStorageRepository(FirebaseStorage.instance));

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository(this.firebaseStorage);

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteFileFromFirebase(String path) async {
    return await firebaseStorage.refFromURL(path).delete();
  }
}
