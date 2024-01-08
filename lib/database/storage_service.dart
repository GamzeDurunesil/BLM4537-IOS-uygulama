import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //resim ekleme

  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    TaskSnapshot storageRef = await uploadTask;

    return await storageRef.ref.getDownloadURL();
  }
}
