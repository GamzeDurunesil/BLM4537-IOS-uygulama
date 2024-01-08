

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/model/favoritemodel.dart';

class DatabaseFavService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  String mediaUrl = "";

  //veri ekliyoruuz

  Future<Favorite> addfavStatus(
    String name, 
    String area, 
      String instruction,
      String photo,
      String category,  
      
      String content1,String content2,String content3,String content4,String content5,String content6,String content7,
      String content8,String content9,String content10,String content11,String content12,String content13,String content14,
      String content15,String content16,String content17,String content18,String content19,String content20,
    String meas1,String meas2,String meas3,String meas4,String meas5,String meas6,String meas7,String meas8,String meas9,
    String meas10,String meas11,String meas12,String meas13,String meas14,String meas15,String meas16,String meas17,String meas18,
    String meas19,String meas20,) async {
    var reffav = _firestore.collection("Favorite");

  

    var documentReffav = await reffav.add({
      'name': name,
      'area':area,
      'instruction': instruction,
      'photo': photo,
      'category':category,
      'content1': content1,
        'content2': content2,
        'content3': content3,
        'content4': content4,
        'content5': content5,
        'content6': content6,
        'content7': content7,
        'content8': content8,
        'content9': content9,
        'content10': content10,
        'content11': content11,
        'content12': content12,
        'content13': content13,
        'content14': content14,
        'content15': content15,
        'content16': content16,
        'content17': content17,
        'content18': content18,
        'content19': content19,
        'content20': content20,
        'meas1': meas1,
        'meas2': meas2,
        'meas3': meas3,
        'meas4': meas4,
        'meas5': meas5,
        'meas6': meas6,
        'meas7': meas7,
        'meas8': meas8,
        'meas9': meas9,
        'meas10': meas10,
        'meas11': meas11,
        'meas12': meas12,
        'meas13': meas13,
        'meas14': meas14,
        'meas15': meas15,
        'meas16': meas16,
        'meas17': meas17,
        'meas18': meas18,
        'meas19': meas19,
        'meas20': meas20,
      
    });

    return Favorite(
        id: documentReffav.id,
        area:area,
        category:category,
        name: name,
        
        instruction: instruction,
        
        
        content1: content1,
        content2: content2,
        content3: content3,
        content4: content4,
        content5: content5,
        content6: content6,
        content7: content7,
        content8: content8,
        content9: content9,
        content10: content10,
        content11: content11,
        content12: content12,
        content13: content13,
        content14: content14,
        content15: content15,
        content16: content16,
        content17: content17,
        content18: content18,
        content19: content19,
        content20: content20,
        meas1: meas1,
        meas2: meas2,
        meas3: meas3,
        meas4: meas4,
        meas5: meas5,
        meas6: meas6,
        meas7: meas7,
        meas8: meas8,
        meas9: meas9,
        meas10: meas10,
        meas11: meas11,
        meas12: meas12,
        meas13: meas13,
        meas14: meas14,
        meas15: meas15,
        meas16: meas16,
        meas17: meas17,
        meas18: meas18,
        meas19: meas19,
        meas20: meas20,
        photo: photo,
        );
  }

  //verileri göstericezz

  Stream<QuerySnapshot> getfavStatus() {
    var ref = _firestore.collection("Favorite").snapshots();

    return ref;
  }

  //verileri silmek için
  Future<void> removefavStatus(String docId) {
    var ref = _firestore.collection("Favorite").doc(docId).delete();

    return ref;
  }
}
