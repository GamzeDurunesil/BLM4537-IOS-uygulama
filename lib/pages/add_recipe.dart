import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_service.dart';
import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MaterialApp(home: new addRecipe()));
}

class addRecipe extends StatefulWidget {
  @override
  _addRecipeState createState() => _addRecipeState();
}

class _addRecipeState extends State<addRecipe> {
  TextEditingController recipeheader = TextEditingController();
  TextEditingController recipeingredients = TextEditingController();
  TextEditingController recipedescription = TextEditingController();

  DatabaseService _databaseService = DatabaseService();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var profileImage;

  Widget imagePlace() {
    double size = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImage!.path)),
        radius: size * 0.08,
      );
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage.toString()),
          radius: size * 0.08,
        );
      } else {
        return CircleAvatar(
          backgroundImage: AssetImage("assets/images/empty.png"),
          radius: size * 0.08,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // ignore: unnecessary_new
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(75),
              child: Text(
                "Tarif Ekle",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
      ), //AppBars

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * .3,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 10),
                      border: Border.all(
                          color: Color.fromRGBO(154, 82, 26, 10), width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            controller: recipeheader,
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: "Başlık",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.image),
                                  onPressed: () => _onImageButtonPress(
                                      ImageSource.gallery,
                                      context: context),
                                  color: Colors.black,
                                ),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: imagePlace()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * .4,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 10),
                      border: Border.all(
                          color: Color.fromRGBO(154, 82, 26, 10), width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            controller: recipeingredients,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "İçindekiler",
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * .5,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 10),
                      border: Border.all(
                          color: Color.fromRGBO(154, 82, 26, 10), width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            controller: recipedescription,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Yapılışı",
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _databaseService
                      .addStatus(recipeheader.text, recipeingredients.text,
                          recipedescription.text, profileImage ?? '')
                      .then((value) {});
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Ekle",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Color.fromRGBO(240, 240, 240, 100),
                    onPrimary: Color.fromRGBO(154, 82, 26, 100),
                    padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromRGBO(250, 250, 250, 1.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => search()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fav()));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ))
            ],
          )),
      //BottomNavigationBAr
    ); //Scaffold
  }

  Future<void> _onImageButtonPress(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("resim ekleme");
        if (profileImage != null) {}
      });
    } catch (e) {
      setState(() {
        _pickImage = e;
      });
    }
  }
}
