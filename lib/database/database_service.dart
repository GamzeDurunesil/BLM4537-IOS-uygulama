import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database/storage_service.dart';
import 'package:flutter_application_1/model/status.dart';
import 'package:image_picker/image_picker.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";

  //veri ekliyoruuz

  Future<Recipe> addStatus(String header, String ingredients,
      String description, XFile pickedFile) async {
    var ref = _firestore.collection("Recipe");

    // ignore: unnecessary_null_comparison
    if (pickedFile == null) {
      mediaUrl = '';
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }

    var documentRef = await ref.add({
      'header': header,
      'ingredients': ingredients,
      'description': description,
      'image': mediaUrl,
    });

    return Recipe(
        id: documentRef.id,
        header: header,
        ingredients: ingredients,
        description: description,
        image: mediaUrl);
  }

  //verileri göstericezz

  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Recipe").snapshots();

    return ref;
  }

  //verileri silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Recipe").doc(docId).delete();

    return ref;
  }
}
