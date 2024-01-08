import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/database/dbforfavorite.dart';

import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';
import 'package:google_fonts/google_fonts.dart';

class FavListPage extends StatefulWidget {
  @override
  _FavListPageState createState() => _FavListPageState();
}

class _FavListPageState extends State<FavListPage> {
  DatabaseFavService _statusfavService = DatabaseFavService();

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: _statusfavService.getfavStatus(),
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
                                "Favorilerden kaldırmak istediğinize emin misiniz?",
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
                                          _statusfavService
                                              .removefavStatus(mypost.id);
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
                                    name: mypost['name'],
                                    area: mypost['area'],
                                    category: mypost['category'],
                                    ins: mypost['instruction'],
                                    ing1: mypost['content1'],
                                    ing2: mypost['content2'],
                                    ing3: mypost['content3'],
                                    ing4: mypost['content4'],
                                    ing5: mypost['content5'],
                                    ing6: mypost['content6'],
                                    ing7: mypost['content7'],
                                    ing8: mypost['content8'],
                                    ing9: mypost['content9'],
                                    ing10: mypost['content10'],
                                    ing11: mypost['content11'],
                                    ing12: mypost['content12'],
                                    ing13: mypost['content13'],
                                    ing14: mypost['content14'],
                                    ing15: mypost['content15'],
                                    ing16: mypost['content16'],
                                    ing17: mypost['content17'],
                                    ing18: mypost['content18'],
                                    ing19: mypost['content19'],
                                    ing20: mypost['content20'],
                                    meas1: mypost['meas1'],
                                    meas2: mypost['meas2'],
                                    meas3: mypost['meas3'],
                                    meas4: mypost['meas4'],
                                    meas5: mypost['meas5'],
                                    meas6: mypost['meas6'],
                                    meas7: mypost['meas7'],
                                    meas8: mypost['meas8'],
                                    meas9: mypost['meas9'],
                                    meas10: mypost['meas10'],
                                    meas11: mypost['meas11'],
                                    meas12: mypost['meas12'],
                                    meas13: mypost['meas13'],
                                    meas14: mypost['meas14'],
                                    meas15: mypost['meas15'],
                                    meas16: mypost['meas16'],
                                    meas17: mypost['meas17'],
                                    meas18: mypost['meas18'],
                                    meas19: mypost['meas19'],
                                    meas20: mypost['meas20'],
                                    img: mypost['photo'])));
                      },
                      child: Container(
                        
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(mypost['photo']))),
                        child: Stack(children: [
                          Align(
                            child: Container(
                              padding: EdgeInsetsDirectional.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 70, horizontal: 1),
                              height: 40,
                              width: 200,
                              color: Colors.black.withOpacity(0.4),
                              child: Text(
                                "${mypost['name']}",
                                selectionColor: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: IconButton(
                                onPressed: () {
                                  _showChoiseDialog(context);
                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                                iconSize: 35,
                              ))
                        ]),
                      ),
                    ),
                  );
                });
      },
    );
  }
}

class details extends StatelessWidget {
  final name,
      img,
      ins,
      area,
      category,
      ing1,
      ing2,
      ing3,
      ing4,
      ing5,
      ing6,
      ing7,
      ing8,
      ing9,
      ing10,
      ing11,
      ing12,
      ing13,
      ing14,
      ing15,
      ing16,
      ing17,
      ing18,
      ing19,
      ing20,
      meas1,
      meas2,
      meas3,
      meas4,
      meas5,
      meas6,
      meas7,
      meas8,
      meas9,
      meas10,
      meas11,
      meas12,
      meas13,
      meas14,
      meas15,
      meas16,
      meas17,
      meas18,
      meas19,
      meas20;

  details(
      {this.name,
      this.img,
      this.ins,
      this.ing1,
      this.area,
      this.category,
      this.ing2,
      this.ing3,
      this.ing4,
      this.ing5,
      this.ing6,
      this.ing7,
      this.ing8,
      this.ing9,
      this.ing10,
      this.ing11,
      this.ing12,
      this.ing13,
      this.ing14,
      this.ing15,
      this.ing16,
      this.ing17,
      this.ing18,
      this.ing19,
      this.ing20,
      this.meas1,
      this.meas2,
      this.meas3,
      this.meas4,
      this.meas5,
      this.meas6,
      this.meas7,
      this.meas8,
      this.meas9,
      this.meas10,
      this.meas11,
      this.meas12,
      this.meas13,
      this.meas14,
      this.meas15,
      this.meas16,
      this.meas17,
      this.meas18,
      this.meas19,
      this.meas20});

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
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    name.toString() +
                        "\n\n" +
                        area.toString() +
                        "    " +
                        category.toString(),
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
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
                      meas1.toString() +
                          "   " +
                          ing1.toString() +
                          "\n" +
                          meas2.toString() +
                          "   " +
                          ing2.toString() +
                          "\n" +
                          meas3.toString() +
                          "   " +
                          ing3.toString() +
                          "\n" +
                          meas4.toString() +
                          "   " +
                          ing4.toString() +
                          "\n" +
                          meas5.toString() +
                          "   " +
                          ing5.toString() +
                          "\n" +
                          meas6.toString() +
                          "   " +
                          ing6.toString() +
                          "\n" +
                          meas7.toString() +
                          "   " +
                          ing7.toString() +
                          "\n" +
                          meas8.toString() +
                          "   " +
                          ing8.toString() +
                          "\n" +
                          meas9.toString() +
                          "   " +
                          ing9.toString() +
                          "\n" +
                          meas10.toString() +
                          "   " +
                          ing10.toString() +
                          "\n" +
                          meas11.toString() +
                          "   " +
                          ing11.toString() +
                          "\n" +
                          meas12.toString() +
                          "   " +
                          ing12.toString() +
                          "\n" +
                          meas13.toString() +
                          "   " +
                          ing13.toString() +
                          "\n" +
                          meas14.toString() +
                          "   " +
                          ing14.toString() +
                          "\n" +
                          meas15.toString() +
                          "   " +
                          ing15.toString() +
                          "\n" +
                          meas16.toString() +
                          "   " +
                          ing16.toString() +
                          "\n" +
                          meas17.toString() +
                          "   " +
                          ing17.toString() +
                          "\n" +
                          meas18.toString() +
                          "   " +
                          ing18.toString() +
                          "\n" +
                          meas19.toString() +
                          "   " +
                          ing19.toString() +
                          "\n" +
                          meas20.toString() +
                          "   " +
                          ing20.toString(),
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
