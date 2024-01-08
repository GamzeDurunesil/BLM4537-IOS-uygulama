import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  String header;
  String ingredients;
  String description;
  String image;

  Recipe(
      {required this.id,
      required this.ingredients,
      required this.header,
      required this.description,
      required this.image});

  factory Recipe.ftomSnapshot(DocumentSnapshot snapshot) {
    return Recipe(
        id: snapshot.id,
        header: snapshot["header"],
        ingredients: snapshot["ingredients"],
        description: snapshot["description"],
        image: snapshot["image"]);
  }
}
