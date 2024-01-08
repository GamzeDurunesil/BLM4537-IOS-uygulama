import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/database/database_service.dart';

import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  DatabaseService _statusService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];

                  Future<void> _showChoiseDialog(BuildContext context) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                "Silmek istediğinize emin misiniz?",
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              content: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _statusService
                                              .removeStatus(mypost.id);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Evet",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Vazgeç",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )));
                        });
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => details(
                                    name: mypost['header'],
                                    ing: mypost['ingredients'],
                                    ins: mypost['description'],
                                    img: mypost['image'])));
                      },
                      child: Container(
                        height: size.height * .3,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1),
                            border: Border.all(
                                color: Color.fromRGBO(154, 82, 26, 1),
                                width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${mypost['header']}".toUpperCase(),
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(154, 82, 26, 1)),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  _showChoiseDialog(context);
                                },
                                icon: Icon(Icons.delete),
                                color: Color.fromRGBO(154, 82, 26, 1),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: CircleAvatar(
                                backgroundImage: NetworkImage(mypost['image']),
                                radius: size.height * 0.08,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
      },
    );
  }
}

class details extends StatelessWidget {
  final name, img, ins, ing;

  details({this.name, this.img, this.ing, this.ins});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  name.toString().toUpperCase(),
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: w,
                  height: h * .4,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(img.toString()))),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "~Malzemeler~",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 350,
                    child: Text(
                      ing.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "~Yapılışı~",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 350,
                    child: Text(ins.toString(),
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, color: Colors.black)),
                  ),
                ),
              ]),
            ),
          ],
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
      
    );
  }
}
