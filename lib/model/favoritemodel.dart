import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  String id;
  String name;
  String content1,content2,content3,content4,content5,content6,content7,
  content8,content9,content10,content11,content12,content13,content14,content15,
  content16,content17,content18,content19,content20;
  String meas1,meas2,meas3,meas4,meas5,meas6,meas7,meas8,meas9,meas10,meas11,
  meas12,meas13,meas14,meas15,meas16,meas17,meas18,meas19,meas20;
  String instruction,area,category;
  String photo;

  Favorite(
      {required this.id,
      required this.content1,required this.content2,required this.content3,required this.content4,
      required this.content5,required this.content6,required this.content7,required this.content8,
      required this.content9,required this.content10,required this.content11,required this.content12,
      required this.content13,required this.content14,required this.content15,required this.content16,
      required this.content17,required this.content18,required this.content19,required this.content20,
   required this.meas1,required this.meas2,required this.meas3,required this.meas4,required this.meas5,
   required this.meas6,required this.meas7,required this.meas8,required this.meas9,required this.meas10,
   required this.meas11,required this.meas12,required this.meas13,required this.meas14,required this.meas15,
   required this.meas16,required this.meas17,required this.meas18,required this.meas19,required this.meas20,
      required this.name,
      required this.instruction,
      required this.area,
      required this.category,
      required this.photo});

  factory Favorite.ftomSnapshot(DocumentSnapshot snapshot) {
    return Favorite(
        id: snapshot.id,
        name: snapshot["name"],
        area:snapshot["area"] ,
        category:snapshot["category"] ,
        content1: snapshot["content1"],
        content2: snapshot["content2"],
        content3: snapshot["content3"],
        content4: snapshot["content4"],
        content5: snapshot["content5"],
        content6: snapshot["content6"],
        content7: snapshot["content7"],
        content8: snapshot["content8"],
        content9: snapshot["content9"],
        content10: snapshot["content10"],
        content11: snapshot["content11"],
        content12: snapshot["content12"],
        content13: snapshot["content13"],
        content14: snapshot["content14"],
        content15: snapshot["content15"],
        content16: snapshot["content16"],
        content17: snapshot["content17"],
        content18: snapshot["content18"],
        content19: snapshot["content19"],
        content20: snapshot["content20"],
        meas1: snapshot["meas1"],
        meas2: snapshot["meas2"],
        meas3: snapshot["meas3"],
        meas4: snapshot["meas4"],
        meas5: snapshot["meas5"],
        meas6: snapshot["meas6"],
        meas7: snapshot["meas7"],
        meas8: snapshot["meas8"],
        meas9: snapshot["meas9"],
        meas10: snapshot["meas10"],
        meas11: snapshot["meas11"],
        meas12: snapshot["meas12"],
        meas13: snapshot["meas13"],
        meas14: snapshot["meas14"],
        meas15: snapshot["meas15"],
        meas16: snapshot["meas16"],
        meas17: snapshot["meas17"],
        meas18: snapshot["meas18"],
        meas19: snapshot["meas19"],
        meas20: snapshot["meas20"],
        instruction: snapshot["instruction"],
        photo: snapshot["photo"]);
  }
}
